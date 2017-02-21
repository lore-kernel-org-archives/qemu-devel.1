Received: from eggs.gnu.org ([2001:4830:134:3::10]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgGBB-0004Zs-MT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgGBA-0004qu-Sf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:32:53 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgGBA-0004qd-Kp
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:32:52 -0500
Received: by mail-wr0-x22c.google.com with SMTP id 89so83972265wrr.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 11:32:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221182859.GH2778@thinpad.lan.raisama.net>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<20170221182859.GH2778@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 19:32:30 +0000
Message-ID: <CAFEAcA9eBdjWTU975LrpAMihM5wMagL4G9bOORc0ypqpmLb=5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 21 February 2017 at 18:28, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Peter, do you think a wrapper for parse_features + object_new()
> would still be necessary to avoid too much code duplication on
> arm boards in 2.9, or can we live without it until we apply
> Igor's series (probaly after 2.9)?

2.9 is very close now. I don't think we need to change any
of the existing board code. Though there are quite a lot that
don't accept -cpu foo,feat=on syntax because they use
object_new() to create the CPU but don't call parse_features,
they've been that way for years (eg since commit 223a72f1179dc0b
from 2014 for versatilepb). We should figure out how we want
to handle this and change all the boards just once, for 2.10.

thanks
-- PMM
