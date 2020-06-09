Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9620C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92ED02074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ED02074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiAs-0002VL-RC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihwZ-0006Yy-IO; Tue, 09 Jun 2020 13:21:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihwW-0002DP-CJ; Tue, 09 Jun 2020 13:21:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MElhb-1jk8yn0PWN-00GKcK; Tue, 09 Jun 2020 19:21:38 +0200
Subject: Re: [PATCH] hw/pci: Fix crash when running QEMU with "-nic
 model=rocker"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200527153152.9211-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bead355e-de7f-e584-53a7-34b2f1664be4@vivier.eu>
Date: Tue, 9 Jun 2020 19:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527153152.9211-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Cr4O4wjTCWxiXehN4KFUgrEPZdF5b9kIEEC9P9ruNOvFo34thnN
 hzy24dxq/VH9PILk8L4mAwCmZeBiPdseWP/cWiAkSA/IhfadtRX2PTGTar2rYoImOxADFmg
 RlyijLzO/Fs7Mk8URelfm5xB8MEvW1vHPE7rZMDbEsCG6gdPeJke2lyx7VraineNSj0cWJj
 r0Ywa1+U+t1i829tCgRvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vxMiUX4g/Pk=:0X8odmsggIcPCWFnPdnaOy
 JwXBQbPpvjne5g7sG7RykDS9Q4tCaXN0R43dgfB2J58GqM7hERLxdDKefvntJj5+USaHeivgi
 uYHUROrBV66SdoGUskI2trlwpMSRfMuRAAg1MUPPnBMsQEzJkPZzDuUgLcB5GS12Xy17ohr/c
 qrD0ejAH66qm5US/3moRH0zRC80NmDure4yYm+G5yY+pOXPNg63zJteJ5tgIk2VCYKuWtlSHS
 ixnIgrIYXDtoiO/xrU/zgS6LuJNeDeykDVDil4+bWKil00SduXgBT7PoBN3aFuvOA0L7XYyW9
 oJ/p62LHuRTQKS5MxSwP+/OsRLiAUUw22QaDnlRUsUJlQpi02FLG6gDYOq3lZ+oOmPwgHB2B7
 eFKF3mqZMrjeBNwOmOVHBloYNUBWjSdq4lLQhOA9aw7deLP6tzWjUuW+KTX9tRHNJpZwGzSwj
 q+Q0PUnPWTzj82v8U+ZPVyTjFs9sl38QxopCj8IqfGYJkFlvhEQQHTREUC+g+0iXx9UCEy3HH
 RABK1Z784r323vyWeO8sR2Bs7YHujfStkn6Mf0YZ+ptFtdpbtYj6RZTikoTZVCmiiPVibB80B
 /03DlMnjgyBjI7utLxOfp1VYcbNdOfeXOkh6uM05KgaCKzCm7/3aV8YvWH+Ap3Z+I3tBmAjn2
 FApG/lApxIDiz27Hb++Bw6V8Zrw2tU6+HQYxfjZl/V83v2RTQnC6gfVES1q3EzB+jGx3nics6
 TClGpU48ScN26tVVeZE01b7r+kgzmxoeCa0pM/UYN78yyIaj0Jit8zOxKil2YSLZw6tIPMiWW
 6unF4rYu9D7nTGX3IxG7eWnDhkKT0T6XYwfNlitzuwQzz44FHJal9txz4XE1UxS1Udwj2HY
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 12:51:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/05/2020 à 17:31, Thomas Huth a écrit :
> QEMU currently aborts when being started with "-nic model=rocker" or with
> "-net nic,model=rocker". This happens because the "rocker" device is not
> a normal NIC but a switch, which has different properties. Thus we should
> only consider real NIC devices for "-nic" and "-net". These devices can
> be identified by the "netdev" property, so check for this property before
> adding the device to the list.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 52310c3fa7dc854d ("net: allow using any PCI NICs in -net or -nic")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..46214f8287 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1887,7 +1887,18 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>          if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
>              dc->user_creatable) {
>              const char *name = object_class_get_name(list->data);
> -            g_ptr_array_add(pci_nic_models, (gpointer)name);
> +            /*
> +             * A network device might also be something else than a NIC, see
> +             * e.g. the "rocker" device. Thus we have to look for the "netdev"
> +             * property, too. Unfortunately, some devices like virtio-net only
> +             * create this property during instance_init, so we have to create
> +             * a temporary instance here to be able to check it.
> +             */
> +            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
> +            if (object_property_find(obj, "netdev", NULL)) {
> +                g_ptr_array_add(pci_nic_models, (gpointer)name);
> +            }
> +            object_unref(obj);
>          }
>          next = list->next;
>          g_slist_free_1(list);
> 

Not really trivial, I will not pick up this patch via trivial-branch,
unless PCI maintainers request it.

Thanks,
Laurent

