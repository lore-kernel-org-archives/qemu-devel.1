Received: from eggs.gnu.org ([2001:4830:134:3::10]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpG4X-00069W-7H
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpG4S-0006bm-KX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:47:29 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:37032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpG4S-0006b2-EV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:47:24 -0400
Received: by mail-wr0-x229.google.com with SMTP id k20so782969wre.4
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:47:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905131149.10669-1-famz@redhat.com>
References: <20170905131149.10669-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 16:47:02 +0100
Message-ID: <CAFEAcA8ULL2=DjcuT5BRipKGm6t95VD-oT6Uh8eYAcTKGKySeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/6] arm: Make use of DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 5 September 2017 at 14:11, Fam Zheng <famz@redhat.com> wrote:
> v6: Rebase and resend v5: Add Philippe's rev-bys and fix one typo in bitband
>     patch.
>
> This is the arm part that was left out from:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04006.html
>
> Make use of the new DEFINE_PROP_LINK, in favor of open coded the
> object_property_add_link. The advantage of it is the property now get reflected
> in the info qtree output, for a bit more introspectability.
>

Applied to target-arm.next, thanks.

-- PMM
