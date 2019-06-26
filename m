Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F270CC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA10B20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAv4-00006U-4N
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgApJ-0004qN-9e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgApI-0007ac-33
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:31:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgApG-0007Vr-2Z; Wed, 26 Jun 2019 12:31:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MkW10-1iQo231uBi-00m1T8; Wed, 26 Jun 2019 18:30:49 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
 <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
 <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
 <20190614185054.6f12ab30@bahia.lan>
 <b40f16eb-5ae5-4b36-e0a8-02b10c3b7769@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ca73d533-644b-a366-2927-4163f9aa2ce9@vivier.eu>
Date: Wed, 26 Jun 2019 18:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b40f16eb-5ae5-4b36-e0a8-02b10c3b7769@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DqaxqHaS92Pb2bEMXsKdWRIb2V+Hw3es/TklEXNJXQ5981NvV9d
 pLyyO+wtt4ZS698ly1jkkkj4ogEfTvskSqJx/sK4otT2WtlDO5wRKJJb5gGKBOH7yn5etST
 CDKflCO3wjus5m+1y1EddmQNJinVBeSTljmZvvJS0RBM5sMkp5mHhlb1VcgeAi6vzoCMitL
 RuOYOaifrM5Chc1WMsurA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2f3pUEZEXz0=:bmNfv80jVFL0ttsOLNUXuh
 XSS9aGc0vkPgyYcGOhjMRWhjLYeQK53GGah9X9y9jo0bkN+bcAU/HvnoA+r1kMGGGYGxn+tu+
 wxMF3s5KUhemAWm5ok7fX9bvfZcoqI6H9meB1/iiGsjjMuBPQ7/xev82YbRWphc4F4kGUFZI1
 t1BGOvIkMjwxzGJpshjgG0DKHsK4qMTI8LdwXkMH1//UJBDyDmq8s5+9FAUaqa0y0beubQ1O/
 WawHFKTZE/sCZIV7sV2vyCY5suab8Z/Q7/f80Eg2jIc7PkNMuZfXV5g8vEvbA4fE5Sz1mwGiH
 YI0kPum6mb1B6UidJckr72l4dQC5keRLiu24ElagD0yjDjOqiI6d+dMHWUssGw457tRQoOZPX
 W3w+KomjKqWw81LexsDX0+hbDU/7thRmbBFJhluKXVzEZPXO3JJOMsEJzL0UV6p/Xc1A0sHhj
 eDCJ0wuG0C4uNnEIJiunD+JxaD3U8kfjEtzwEnzqqQ1sFUWq7zPE+SgIqjPalqw6KPk0QhcGE
 EEpHvP2hSd7rsmi+Rtl4wAG8OqZm5mViALVNameKmdAMaywaAbVlQldsUQvyTWACRIbYpE+pD
 DPiBjtqy2P6JHDp7V9FeCg6yOm9Ebxoodl55SWW5U2BOvYPiHzgiWz7wiivOSuaYgr5DEg3mK
 Art2zK/6AZSXbMBhEhqOngd/JmslFmHWztT4bNqYTAQV23Z8itgsdSDVd+HV7/6k9KbkGd587
 iLbLZKkcSMYyGsggYF8xaOwva0n61HIAtboEvA9XFo5wRSOZ9pIYJFOfpVM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Change
 maintership of Xen code under hw/9pfs
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Paul Durrant <Paul.Durrant@citrix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/06/2019 à 07:43, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial@
> 
> On 6/14/19 6:50 PM, Greg Kurz wrote:
> [...]
>> Markus, Xen maintainers,
>>
>> All needed Acked-by have been provided. I don't plan to send a 9pfs PR
>> anytime soon. Can this go through someone else's tree please ?
>>
>> Cheers,
>>
>> --
>> Greg
>>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

