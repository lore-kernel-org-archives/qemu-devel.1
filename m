Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35374C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4234520663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y4ETKVsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4234520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iflU9-0006yx-1S
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iflTJ-0006NL-5y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iflTH-0003jP-Qy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:59:08 -0500
Received: from mail-bgr052101135069.outbound.protection.outlook.com
 ([52.101.135.69]:59650 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iflTH-0003Y8-5c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:59:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb+cifxx9pjGe5uAV/Ps+Sjwfl21WQepFNpJjoQB3zqoEoyORuuo90nhF3chQQlGbvOqEIm+nihXc1NsVU0CQ44+xi8eD/jk1j6gGgP7VxRL0oyH+UCk+1E9jTDpM8JqyczyblbmTQTcuUkKyG/IppzsNUUCQWDMYtNv/JF4xlA6RVDdlap/HtF9sX9JuieQfO3BZ+/s8neG3pSgWPxJIBKo2uVFBtmKwcLx6RleZaiU+wT4X+i/fS3U+XR0MMmf4Mub06j11t62zNQqI07hilU2jprMSbizxlToD77mjsHiNUlmJ+Md+huDLJRUOZ90Yl/g4eLB5DqTQ4aIKKGiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OofLzLOX3EsPd6Baoc8uQkwoDkvQrTQWy7/XHU4gQb8=;
 b=hm0n45rX7ppMQJwx0EEdE68tBOh6NBHpVhgtdN6DICN6QwBsotCMWit7tM5BSKJ+4iuYfQ8FWI6T/S8DecOrEezf9cEcyjulgLWr20K0UUrzTV6dz+7C7t75hfHxlSjN05bi7gmxK2CLBQva7OylLHKs2sEtB+8TdGumt8bKRogonaIWvVIYbPjbyVJyc7Noq/WgM93ZromfNBW2W9yWhq2876DrdlRGZsZhImYHmaMxYTiiUBBTB9KQOYj8SNU1PRtYn9NQP6ajWX9BrTXRg7yhUMwMfL6xJZBvjq9J/vful1dF1PLdsvyHAH467ZmSSOr4QhSPG3vtsqJElZfoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OofLzLOX3EsPd6Baoc8uQkwoDkvQrTQWy7/XHU4gQb8=;
 b=Y4ETKVsSRvsottwn/YDlIrzjwpvU4RTc5B0R9sGqpGKzU/IAR3JJtsQOYQFeKl5ZSJIr8KlmOnJ9rlluu1UPIMkOQMyUyzmF7vYqad5gfXydwevVIjfqWWMALpTuHIj6+ZZo2htstYzW6coBgFkWCIjAXNrkMueIq7OetR7vL7s=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3293.eurprd08.prod.outlook.com (52.133.12.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 13:58:53 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::78fe:4abd:2c04:1bf2]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::78fe:4abd:2c04:1bf2%4]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 13:58:53 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] hyperv: Use auto rcu_read macros
Thread-Topic: [PATCH 1/2] hyperv: Use auto rcu_read macros
Thread-Index: AQHVsbf6Vh3Vr/zLSUqBkewjGsYN1ae4F3OA
Date: Fri, 13 Dec 2019 13:58:52 +0000
Message-ID: <20191213135849.GA74178@rkaganb.sw.ru>
References: <20191213131931.143878-1-dgilbert@redhat.com>
 <20191213131931.143878-2-dgilbert@redhat.com>
In-Reply-To: <20191213131931.143878-2-dgilbert@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert
 (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, cota@braap.org
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::11)
 To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8659335-eba9-4986-7e84-08d77fd49649
x-ms-traffictypediagnostic: VI1PR08MB3293:|VI1PR08MB3293:|VI1PR08MB3293:
x-microsoft-antispam-prvs: <VI1PR08MB3293617081A6B068878DC9BAC9540@VI1PR08MB3293.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(366004)(39840400004)(136003)(376002)(346002)(189003)(199004)(6916009)(186003)(33656002)(9686003)(6486002)(26005)(5660300002)(4326008)(54906003)(316002)(1076003)(478600001)(64756008)(66446008)(52116002)(36756003)(6512007)(6506007)(71200400001)(66946007)(81156014)(2906002)(66476007)(81166006)(8676002)(86362001)(8936002)(66556008)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3293;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77ag3aD0blUFrt8zxdXC8nW4+nojdZhJh66pTO9qQZHfoUnhTIWUFw+2QopScaT2q/f/jllE1iiuLLLrSkDCpt3JyQhKl/rjdOB7tfpka27mDLkZ6/i7T2jTO1Lk4kOtf8+JZfjKiEjpZthG1kyllgQ2I5SHf3sVG6SiwjfvcexYel2FwytO/0w0BXVb95jjSMRgFHFZtQOzlpbs0mhtFaRIAPoEwMguIJS3uZWrxkUiakeV8STvV7r+z2ZO3HPwoG5yQfp7hKhiF/dctDoI9C8OLOU0WZYJn9PoRBgNzRkGIRlIxCnFXtoQO05gi95FqxV03W6UUli1LoBm7WA2VLYzsdM4zuK7+P1aKVQlP5gGXo026CoaQS/Tcy8JT7E+MBQHLJwKXS363bo4/7rTqWfqDzTcADk9Ba50Dua5D/rgZopPeR/INOEHnGfxGeo4wYYRCacOTvGEzbmezyP9au7czuBi/AJzr0+gXdSZ43II+hcvEw2e1u5CEnNv4ygEdq1o5k9yPWjtrPpPW0mNQwkH2gk0KM7lv6+Wn26roHedGJVP6oHfk7zfqXTHq4ykkjRleMKbK8rSoysMwBCAV64v3CPtWkdI9twnDhL3eewQMRPy0EsooqqeUkcSBfu2R7wvrlNGwopZ6EUtR5tzstnKFMjpI4UdFXOeBBZOkzmoHVpydgYI0jdb7AkIspO66cRoqSymBH1s5/Un/gHDY4KLEFQoWP/mhrgd6ooyrO7GdiPmMYu9Qmo8XQycY2TgZxUmUFedddm6+K+/g/yfaw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A882E1544640D44D9B3C194CAF3CC68A@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8659335-eba9-4986-7e84-08d77fd49649
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 13:58:52.9446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98dgZoLwfRtxJutWmM6ANSTM4P2jeotJK+S2BdiFNwU4qRqGm0WXOhrxgjXSMVhd5KLrOqPaMpz1T13vM4n2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3293
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.69
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 01:19:30PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
> to replace the manual rcu_read_(un)lock calls.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/hyperv/hyperv.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 6ebf31c310..da8ce82725 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -546,14 +546,14 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
>      }
>  
>      ret = HV_STATUS_INVALID_CONNECTION_ID;
> -    rcu_read_lock();
> -    QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
> -        if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
> -            ret = mh->handler(msg, mh->data);
> -            break;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
> +            if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
> +                ret = mh->handler(msg, mh->data);
> +                break;
> +            }
>          }
>      }
> -    rcu_read_unlock();
>  
>  unmap:
>      cpu_physical_memory_unmap(msg, len, 0, 0);
> @@ -619,7 +619,6 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>  
>  uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
>  {
> -    uint16_t ret;
>      EventFlagHandler *handler;
>  
>      if (unlikely(!fast)) {
> @@ -645,15 +644,12 @@ uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
>          return HV_STATUS_INVALID_HYPERCALL_INPUT;
>      }
>  
> -    ret = HV_STATUS_INVALID_CONNECTION_ID;
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      QLIST_FOREACH_RCU(handler, &event_flag_handlers, link) {
>          if (handler->conn_id == param) {
>              event_notifier_set(handler->notifier);
> -            ret = 0;
> -            break;
> +            return 0;
>          }
>      }
> -    rcu_read_unlock();
> -    return ret;
> +    return HV_STATUS_INVALID_CONNECTION_ID;
>  }

I have a slight preference towards using WITH_RCU_READ_LOCK_GUARD
instead of sticking RCU_READ_LOCK_GUARD in the middle of the function
and implicitly relying on there being none but trivial statements past
the rcu-protected section.

Nothing that I would insist on, though, so

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

