Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4WF-00064w-Oc
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4WA-00050H-21
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:00:55 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:45959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez4W9-0004zh-TL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:00:49 -0400
Received: by mail-ot0-x22c.google.com with SMTP id h26-v6so2981492otj.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:00:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152174145840.240.3926671265619235661@71c20359a636>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<152174145840.240.3926671265619235661@71c20359a636>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 18:00:28 +0000
Message-ID: <CAFEAcA_Uxhrh2L+FghG7y2r7n36rfo41jKw9vdGZYo32nk28cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 22 March 2018 at 17:57,  <no-reply@patchew.org> wrote:
> Checking PATCH 4/4: Remove unnecessary variables for function return value...
> ERROR: return is not a function, parentheses are not required
> #251: FILE: target/mips/dsp_helper.c:3281:
> +    return (temp[1] << 63) | (temp[0] >> 1);

This looks like a bug in checkpatch. I guess to fix it you'd need
to make checkpatch count opening and closing parens in the line
to see if it goes to 0 somewhere other than just before the ';'...

thanks
-- PMM
