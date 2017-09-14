Received: from eggs.gnu.org ([2001:4830:134:3::10]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVQj-0004P7-0j
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVQi-0006e4-5p
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:47:49 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:47690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsVQh-0006dZ-U8
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:47:48 -0400
Received: by mail-wm0-x231.google.com with SMTP id 13so1144121wmq.2
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:47:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914123609.497-1-dgilbert@redhat.com>
References: <20170914123609.497-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 15:47:26 +0100
Message-ID: <CAFEAcA9LGWjB9cpsgSbbyuWnA7Ev=t6AY6uwm_NTif7TZdW0dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sparc: Fix typedef clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 14 September 2017 at 13:36, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Older compilers (rhel6) don't like redefinition of typedefs
>
> Fixes: 12a6c15ef31c98ecefa63e91ac36955383038384
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks; applied to master as a buildfix.

-- PMM
