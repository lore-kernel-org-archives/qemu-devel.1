Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D85CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FFD218BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FFD218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRd1K-0005Pk-RD
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 09:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRd0c-0004yJ-B0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRd0b-00061b-7o
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:07:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iRd0a-00061K-V3; Mon, 04 Nov 2019 09:07:05 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mqagw-1i5iOx2AVM-00mdM2; Mon, 04 Nov 2019 15:06:59 +0100
Subject: Re: [PATCH] qom: Fix error message in object_class_property_add()
To: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <157287383591.234942.311840593519058490.stgit@bahia.tlslab.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c1fcf973-b469-2a1f-e882-4fa1608ffe44@vivier.eu>
Date: Mon, 4 Nov 2019 15:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157287383591.234942.311840593519058490.stgit@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wcTnzZ7q4DPtT8C2LdRql1HDCo/5Cjn+ksjFgqNPKMVZfXOBkEZ
 96i6gL5wHByGNfaYjC8DRrdO9/3bVGBlvPkcjbHPoyTvHBK2VP+9V6ZRSKvmJlKfViDezBr
 Tw3n/cDwh8ZrwA6KzDweJSkWwrxEn86evZUiY0vVbNPiExu3MnwdFO3tCjCoy16mb8giRl1
 /JxPyq63VvLix9wBXcWDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BGjlrFCLmMI=:zAoj3/mGRV5TsKZOg9gATC
 O1GOA04WWNsKkGaXbyCxCG1s8m02OR9wn99jlGN721gi1uV3nosELLF6zHIb0cBvrsrWc8WrC
 YKn2FcshaD1VSci/jxRxMhjLsh/tWy4PYrSwp7NvRW0PwM7Arr3HkMyqsdVE8JRJM9fm22isr
 eqq76kRJmzEJNxWPCaHOUDRvRPnWHpwS7552I8j5It77OGATbPsmXjkiL90uX37tfBOsNIZNY
 demaFSG901wxx5ygW1q0QkO1B53+blFy4hmLar49cbJT6V6zoxIGPdDuqtJluii/G4TO3c11g
 GdA5+KY5EX4kQ+tk6P1iCvLvyCF8QrU0fIeOeQ7rwhGwchYs3ejkTfAtVEpyP79OWA3OEuNyK
 UF1k2Qz5w9u677YwL8zGH1qUErVgj6Jq/k1SMHZaJE5CbTC81XoC+O1vP8LycGx4c5m/w8ZS/
 etNVUdZqsB7cth0FRhNYg7xG7bUMEWtP/JrGHEKmUACtvi00JO4oCBPb7jq0QfDpMa1ZGBNIY
 IWQS5IO0/989eBRAqf/OVJss/A5YmAl0Fvu1hXA46+GSYEfr/fmh2yOSkpx+qXS1GILNMXkNT
 Inoq2LovNUkkkVXIB0nqH387RY1RH06+ShobHaK6C5Y7BTWP6BjWc7MHQVbw42rEPLXxpa/4p
 szHMie2x0qQwwClBAMWBe0lRjiqIkjqfN8fTvmG+PhzQI7RfYrRPfjFsmqHILGNiZKUszUbxe
 hW8OWn6gkJ+lfyRsl0Xrmy92m2fWbY22VDvmf0MKXqLbK7tPUOe9wlJyo6uCosPOHWXUXT3LE
 xO8oHc3gnVyYc+LL9av5tYFtdl2Z7Jho8YZ9OQI4Pzf+o0eC601EMR+szP6Wv/mg9376ArfoC
 3W6VdP4sPKuzj/zDJkztz+/FCj2DceZuwP456Jse4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/11/2019 à 14:23, Greg Kurz a écrit :
> The error message in object_class_property_add() was copied from
> object_property_add() in commit 16bf7f522a2ff. Clarify that it is
> about a class, not an object.
> 
> While here, have the format string in both functions to fit in a
> single line for better grep-ability, despite the checkpatch warning.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  qom/object.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 6fa9c619fac4..d51b57fba11e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1106,9 +1106,8 @@ object_property_add(Object *obj, const char *name, const char *type,
>      }
>  
>      if (object_property_find(obj, name, NULL) != NULL) {
> -        error_setg(errp, "attempt to add duplicate property '%s'"
> -                   " to object (type '%s')", name,
> -                   object_get_typename(obj));
> +        error_setg(errp, "attempt to add duplicate property '%s' to object (type '%s')",
> +                   name, object_get_typename(obj));
>          return NULL;
>      }
>  
> @@ -1139,9 +1138,8 @@ object_class_property_add(ObjectClass *klass,
>      ObjectProperty *prop;
>  
>      if (object_class_property_find(klass, name, NULL) != NULL) {
> -        error_setg(errp, "attempt to add duplicate property '%s'"
> -                   " to object (type '%s')", name,
> -                   object_class_get_name(klass));
> +        error_setg(errp, "attempt to add duplicate property '%s' to class (type '%s')",
> +                   name, object_class_get_name(klass));
>          return NULL;
>      }
>  
> 
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

