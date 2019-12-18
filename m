Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A27C2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B50218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B50218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYn6-0004bC-DQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYU4-0002pq-6Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYU2-0004jU-P9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:31:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:43505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYU2-0004Zh-Dz; Wed, 18 Dec 2019 07:31:18 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MtwQm-1hpqvm2hsS-00uINP; Wed, 18 Dec 2019 13:31:06 +0100
Subject: Re: [PATCH-for-5.0 v3 3/6] hw/pci-host/i440fx: Use size_t to iterate
 over ARRAY_SIZE()
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-4-philmd@redhat.com>
 <a4745134-47dc-ab8a-6009-69fcc9dfbb02@redhat.com>
 <46339299-e45b-79a3-5b45-f62fb5c7b26f@vivier.eu>
 <b629cd94-95e9-d351-6e80-23594c2b6245@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <53a50728-bb9c-cc12-f8f9-772212c8bb24@vivier.eu>
Date: Wed, 18 Dec 2019 13:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b629cd94-95e9-d351-6e80-23594c2b6245@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+xoPBD6VXrG2Cqi+lBl0RClNe9MmdG8QUIVqR4EgQ6v/VbcbF1d
 PJbztJQco7m2uU5Snle66avjwjLV3LMJacWFhwoCEke0KkWeoGmS+9iEGtwagDEqMDXTzMT
 rGKqdcmyr7P7VdB0g3qzPTmVIVoinpkvVRXqtrzXS0Zob3V1hq3l4lb0zvnEM5BLOy57Vwa
 i0WNwZ5mnoeTsVfYPKU+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2UIROFX/rNI=:xYEWcLx1RE2ehPrwhvP4N/
 b6YdXCUz0AQ0H9u+r7Utd6deuNGNUWTxavR2ImB0iL4i72ju1vlgrfGIm0R02L2JLzf1qlYkU
 0YsKF5k0Yw24AeA8SAOBhdxfbI4e4gMOxFt0Yspptt7WXB2zjAxEQpaz/IW2m+FL0aGOoDZbq
 jPIOxh/1a1TFtEIgPgtE1qO3DqIyuZr91bHgMnQqbBU2pnI1T1GKnq0AnhvDHzP3obzGWgl2N
 DJHF33NT5KcxV0DBo7cMncUYtc8aOz1q2tJPndamGwWeu45lvfjY7ijzDUev31gGy1Meof+ul
 4OUfpM86ZPV0nmie4u1u8rq/gjECj7t1uu34vBuDARlGCuCP19MHlh818ZzEw57NR87ZObdAi
 VAws6KJsUvaGoy3Uh1I/78tKrS51AZcSS/e6aeYMaaZj+2EcRWvuC62j67QOcWMdvUCOOauCv
 KedX9OHGRGxV4Vi7D77i7tKBzugAfMZGBawX+JQgzCvk1p9SaBGZ49TUdf7vY3LyzOQIgLvNr
 k4DAv9Pw8Sn5aY86z0ySL4DK+9zX4WVaiz0Jy/rEj5FLxB2mH6+f41eNettkZ6dpNH84q91AQ
 SIegLF/JnjJmU3chmUbJV1xOz6/fWO/Pn39cU6CIbwO/4Vvs6+k3PLRhjhzK1tZBYceI2Y22S
 mqMWGdGsZRDW2Ep9+C6k5UO2ApRxHSBDgZezY9LHKEs3Wy0LMU1Nk5rhuEn1Lo1Eyw4Akc+H1
 KImTF47OPMYfX/Dzcb7OASrbQsHIZJ2rAERW/Kzrj41jTr8dAt7gNJpsbxXDFop3u9c1+Cs98
 OrcZC0T8QZI0nd1Xl7uIdtg7tFuAUznrxvqr0Q3S1WXwDb7FXT4mUhkV1JPbEPTucvsWMYQzM
 kHHv1ZYo+26jGcgs6TytfI+UjVM+VEKF04vfHhvs8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/12/2019 à 13:01, Paolo Bonzini a écrit :
> On 18/12/19 12:57, Laurent Vivier wrote:
>> Le 09/12/2019 à 11:05, Thomas Huth a écrit :
>>> On 09/12/2019 10.49, Philippe Mathieu-Daudé wrote:
>>>> We don't enforce the -Wsign-conversion CPPFLAG, but it doesn't hurt
>>>> to avoid this warning:
>>>>
>>>>   warning: implicit conversion changes signedness: 'int' to 'size_t' (aka 'unsigned long') [-Wsign-conversion]
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>  hw/pci-host/i440fx.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
>>>> index fbdc563599..0cc80b276d 100644
>>>> --- a/hw/pci-host/i440fx.c
>>>> +++ b/hw/pci-host/i440fx.c
>>>> @@ -419,12 +419,11 @@ out:
>>>>  static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
>>>>  {
>>>>      uint32_t val = 0;
>>>> -    int i, num;
>>>> +    size_t i;
>>>>      int pos, len;
>>>>      Error *local_err = NULL;
>>>>  
>>>> -    num = ARRAY_SIZE(igd_host_bridge_infos);
>>>> -    for (i = 0; i < num; i++) {
>>>> +    for (i = 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
>>>>          pos = igd_host_bridge_infos[i].offset;
>>>>          len = igd_host_bridge_infos[i].len;
>>>>          host_pci_config_read(pos, len, &val, &local_err);
>>>>
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>>
>>
>> Applied to my trivial-patches branch.
> 
> No need to, I've already queued the whole series.
> 

ok, I've removed them from my queue.

Thanks,
Laurent


