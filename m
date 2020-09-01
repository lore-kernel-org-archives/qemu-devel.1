Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32920C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F52206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F52206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD38m-0004AS-4H
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD35f-0007ae-GC; Tue, 01 Sep 2020 06:00:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD35b-0004lK-Ke; Tue, 01 Sep 2020 06:00:35 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MkYsS-1krMRU2wSE-00m3MR; Tue, 01 Sep 2020 12:00:22 +0200
Subject: Re: [PATCH v3 06/10] hw/net/virtio-net:Remove redundant statement in
 virtio_net_rsc_tcp_ctrl_check()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200827110311.164316-1-kuhn.chenqun@huawei.com>
 <20200827110311.164316-7-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <290e1a37-46c3-b282-2cd6-5fecbcc4b64f@vivier.eu>
Date: Tue, 1 Sep 2020 12:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827110311.164316-7-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OuVLr3SD5gwnOEv9orT+8BHbDOAIHkfKN93LqDYh0LW20CVhHu/
 Xu0AOcFAfGNUeS2q8O71U9qe/3+XNaVjO1KOI5Z13VC5LMvK2VGa8Ovz4/5SU9og1F8D4uI
 GZQrdC1+Yyuf02KWaUB9sjL8xoLU3t8H7f4a92dGxIPX7zoKUl7nk6f4zPDPIDPV/HrvZt0
 V5Cws1I5TsLv/o+mT5e7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8OI62L09uuU=:SsyI8NqGA7Qc7OXCT417TI
 ZaOXbnrFoYOG0VeCrm4Dz77C1l76qFUi2EdxI0JGFR5BcbV6HMmZH12Myy0n772R+d2hskSBd
 b4bKyUY2DhDgn+gnEcB9yGmaqDwJTaxfVnRO2fMDC9cfecTnZSY8eUxvXpiLnf/P25mUoGp0a
 VGroVXj/TJW33FtmvGG9Pk8FiFDrNteFIhnJJDRiKvcXfAWfDi02U0KZZxXhC1AaXJLAOlgZT
 RtnbzzPkPtpUQAvHaI9AYbEERQsG77/sQmj5Ypvk+bp2LvPWVSVjQRomHzRtX+JMg6Jkxt0T4
 9ShZj3W5dwuBXjr4LViqd1mEUVvK3M2TtmO6fd02/UyDq78l9M/yc2g2O0VG5abpeLiX0cXWH
 PqewFCTTZV/MSBjsJ/DEdO+B4y5QXm0ts6jUTLqzy26yolLbVOoN88M+EcSRXQfvIfcwrFK4K
 reUMP3dOScshO7hwsKTFkbRuP1Himl9tTmI1zeOWndN81+QzbGV1an7COrILV9pASL9sF9c66
 V2c45StlUTr/maHlwubVPs/ZMT1iR8su+pKRr/KW1t1rg6XGaxEOKBAA4CcfSsrZlWjN5RcBg
 arhNDiSl5vC0h/n++lrJvq58OGW8gi6s1ElU8wBXtKlqd8Ggp/h1imRO5GawPHXxaJOhvTtol
 w1YYUeb7OUrIE8PomIlTj20t9L6lpCtRbJKtq4RfAIOxaVRDwecabjlqSAv0dngsGu8NRbreu
 X+IrgTcZYG6iXoK6tVlSVunIDS+lRHF3jz9opgzsTYghRq7hnSv+xvZd3rpJ4999QgyomxWxL
 pE5/D2hm6eEe2MT6Blwi9/x+qI2g7nmNU9AuNWFumNispCz3SJZh2LJV593y33Rh7k1avx+
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:47:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 pannengyuan@huawei.com, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Euler Robot <euler.robot@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/08/2020 à 13:03, Chen Qun a écrit :
> Clang static code analyzer show warning:
> hw/net/virtio-net.c:2077:5: warning: Value stored to 'tcp_flag' is never read
>     tcp_flag &= VIRTIO_NET_TCP_FLAG;
>     ^           ~~~~~~~~~~~~~~~~~~~
> 
> The 'VIRTIO_NET_TCP_FLAG' is '0x3F'. The last ‘tcp_flag’ assignment statement is
>  the same as that of the first two statements.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a1fe9e9285..cb0d27084c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2075,7 +2075,6 @@ static int virtio_net_rsc_tcp_ctrl_check(VirtioNetRscChain *chain,
>      tcp_flag = htons(tcp->th_offset_flags);
>      tcp_hdr = (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
>      tcp_flag &= VIRTIO_NET_TCP_FLAG;
> -    tcp_flag = htons(tcp->th_offset_flags) & 0x3F;
>      if (tcp_flag & TH_SYN) {
>          chain->stat.tcp_syn++;
>          return RSC_BYPASS;
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


