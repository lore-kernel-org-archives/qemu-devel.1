Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09BC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956522145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956522145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnM6X-0002uG-QP
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hnM6M-0002Oq-En
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hnM6L-0007we-GA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>)
 id 1hnM6J-0007v9-EU; Tue, 16 Jul 2019 07:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89FF13082135;
 Tue, 16 Jul 2019 11:58:30 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D82A5E7A5;
 Tue, 16 Jul 2019 11:58:23 +0000 (UTC)
To: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org
References: <20190716105951.25446-1-rfried.dev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f6b7308b-f642-a691-eb97-1d74360aebac@redhat.com>
Date: Tue, 16 Jul 2019 19:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716105951.25446-1-rfried.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 16 Jul 2019 11:58:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] net: cadence_gem: clear RX control
 descriptor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@gmail.com, alistair@alistair23.me,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/16 =E4=B8=8B=E5=8D=886:59, Ramon Fried wrote:
> The RX ring descriptors control field is used for setting
> SOF and EOF (start of frame and end of frame).
> The SOF and EOF weren't cleared from the previous descriptors,
> causing inconsistencies in ring buffer.
> Fix that by clearing the control field of every descriptors we're
> processing.
>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> ---
> v2:
>    * change function name to rx_desc_clear_control as proposed by
>      Jason Wang
>    * Move the function call above the comment, as proposed by
>      Philippe Mathieu-Daud=C3=A9
>
>   hw/net/cadence_gem.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index ecee22525c..cca3ce7f56 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -406,6 +406,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
>       desc[1] |=3D DESC_1_RX_SOF;
>   }
>  =20
> +static inline void rx_desc_clear_control(uint32_t *desc)
> +{
> +    desc[1]  =3D 0;
> +}
> +
>   static inline void rx_desc_set_eof(uint32_t *desc)
>   {
>       desc[1] |=3D DESC_1_RX_EOF;
> @@ -993,6 +998,8 @@ static ssize_t gem_receive(NetClientState *nc, cons=
t uint8_t *buf, size_t size)
>           rxbuf_ptr +=3D MIN(bytes_to_copy, rxbufsize);
>           bytes_to_copy -=3D MIN(bytes_to_copy, rxbufsize);
>  =20
> +        rx_desc_clear_control(s->rx_desc[q]);
> +
>           /* Update the descriptor.  */
>           if (first_desc) {
>               rx_desc_set_sof(s->rx_desc[q]);


Applied.

Thanks


