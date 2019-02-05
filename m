Received: from eggs.gnu.org ([209.51.188.92]:54734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gr7VV-0005dp-Uf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gr7J9-0002rS-Ng
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:27:04 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gr7J9-0002qi-HC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:27:03 -0500
Received: by mail-wr1-f54.google.com with SMTP id a16so5191604wrv.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 12:27:03 -0800 (PST)
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8-Hst3Buax1Qrrm1SVbTtkE-8a_Vj0y3N4TvfPTqR_zw@mail.gmail.com>
	<CAFEAcA9Yh=fCuBT602deTt0OJQux9ZMGXvGX3Bx_iXNiTskNSA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a95fbfc3-cc8f-8836-1bb8-8e14431563c2@redhat.com>
Date: Tue, 5 Feb 2019 21:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Yh=fCuBT602deTt0OJQux9ZMGXvGX3Bx_iXNiTskNSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/76] misc patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/02/19 21:05, Peter Maydell wrote:
> This part looks like the usual "foo-softmmu/config-devices.mak isn't updated
> if a file that's #included from default-configs/foo-softmmu.mak is
> changed" dependency bug -- I guess the fix for that isn't in this
> patchset ?

No, this pull request is not the full Kconfig stuff.  I will at least
run it more closely past target maintainers before landing it. :)

Paolo
