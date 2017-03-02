Received: from eggs.gnu.org ([2001:4830:134:3::10]:60515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWpH-0001Nd-3l
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWpG-0003U2-AQ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:55:47 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWpG-0003T4-42
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:55:46 -0500
Received: by mail-wm0-x230.google.com with SMTP id n11so168225wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:55:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6a3ecc27a153a5e79ba19542760c3037fe5c75f4.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6a3ecc27a153a5e79ba19542760c3037fe5c75f4.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:55:24 +0000
Message-ID: <CAFEAcA_dY4UF8s8JtxGUtjJ_Mfvz5Gv3Mfypz45TAtnHuHQY7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 03/14] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 3 December 2016 at 02:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

It would be helpful to mention in the commit message that we don't
yet implement reset or vmstate and that those are coming in a
later commit.

(There is almost always something useful to say in a commit
message body; subject-line-only commit messages should
be the rare exception in my opinion.)

> +
> +static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = sm501_realize_sysbus;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->desc = "SM501 Multimedia Companion";
> +    dc->props = sm501_sysbus_properties;
> +/* Note: pointer property "chr-state" may remain null, thus
> + * no need for dc->cannot_instantiate_with_device_add_yet = true;
> + */

This comment should be indented.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
