Received: from eggs.gnu.org ([2001:4830:134:3::10]:58364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dsQ1B-0008El-4y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dsQ16-00044t-6d
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:01:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <539c675e-ed87-728c-c9d0-058ae46eb018@amsat.org>
References: <20170913082817.24731-1-berto@igalia.com>
	<539c675e-ed87-728c-c9d0-058ae46eb018@amsat.org>
Date: Thu, 14 Sep 2017 11:00:19 +0200
Message-ID: <w51vaklirj0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] throttle: Assert that bkt->max is valid in
 throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

On Wed 13 Sep 2017 06:31:58 PM CEST, Philippe Mathieu-Daud=C3=A9 wrote:

>> If bkt->max =3D=3D 0 and bkt->burst_length > 1 then we could have a
>> division by 0 in throttle_do_compute_wait(). That configuration is
>> however not permitted and is already detected by throttle_is_valid(),
>> but let's assert it in throttle_compute_wait() to make it explicit.
>
> This is correct but I'm not sure this is enough, as
> throttle_compute_wait() is exported/public, however it seems testing
> is the only reason to export it.

You're right but in general I don't think the throttling code is
guaranteed to behave correctly if the configuration hasn't been checked
with throttle_is_valid() first.

> Also I spent 10min looking at it thinking about how bkt->max is used,
> before to realize there should be a simpler way to write this (KISS).

I'm sure there is :) if you have suggestions I'll be glad to hear them.

Berto
