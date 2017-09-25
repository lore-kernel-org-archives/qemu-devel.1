Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwTIR-0005oY-NV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwTIL-0007V7-QZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:19:39 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:44419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dwTIL-0007N9-LG
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:19:33 -0400
Received: by mail-pf0-x235.google.com with SMTP id e1so3777333pfk.1
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:19:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-2-dgilbert@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d831a4f1-2598-66c2-6e84-a9ab93cf3bff@twiddle.net>
Date: Mon, 25 Sep 2017 08:19:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170925112917.21340-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com
Cc: peter.maydell@linaro.org, cohuck@redhat.com

On 09/25/2017 06:29 AM, Dr. David Alan Gilbert (git) wrote:
> Modify the pre_save method on VMStateDescription to return an int
> rather than void so that it potentially can fail.

What does the int value signify?  Why not a bool?


r~
