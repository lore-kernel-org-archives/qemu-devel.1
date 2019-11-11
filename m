Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485AB21655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSmw+1zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485AB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU8GV-0001Ik-Eo
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iU8Fo-0000qT-AX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iU8Fk-0003AG-FJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:53:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iU8Fk-00038w-16
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573473182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppDbyQQBYmMNbfaSaQPOjZ9c5naPfZz0RDJpZp0PC5Q=;
 b=CSmw+1zXX8mYg+3hHUP5w8efSmBsQSkwBwQB+9ufjI966z3dixmndz6JNkSTcV99fJlmMw
 A003EGVgTIlLfzWT2Y1QwF6eeHdpMI54WHzxwdmLc4xVTglQkiz4rBZZGX+c6EqbDiYzLm
 oVkYoWFPBaGClbxWEA1iTOwsTZHQeN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-RR71SIFOMgif_wZvZS8Ghg-1; Mon, 11 Nov 2019 06:51:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39789800C61;
 Mon, 11 Nov 2019 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE704145;
 Mon, 11 Nov 2019 11:51:07 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
 <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
 <51f9b2d9-b196-c30e-dc67-988e29b5df47@redhat.com>
 <CAFEAcA8EijZRqhFerQbq5cCbaq-qzrMzOrQjc6Ro=v2p6=W_pA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac065856-56e2-bceb-851c-a9c150068e71@redhat.com>
Date: Mon, 11 Nov 2019 12:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8EijZRqhFerQbq5cCbaq-qzrMzOrQjc6Ro=v2p6=W_pA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RR71SIFOMgif_wZvZS8Ghg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 18.10, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 17:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>> On 11/8/19 4:43 PM, Eric Blake wrote:
>>> bzip2 is no longer a favored compression.  If we are trying to pick a
>>> compression that is most likely to be present on any system, go with
>>> gzip.  If we are trying to pick a compression that packs tighter and
>>> uncompresses faster, pick xz or zstd.  But bzip2 does neither: it packs
>>> slightly tighter than gzip but has slower performance in doing so, and
>>> thus is no longer used as a default compression.
>>
>> The problem was with OpenBSD 6.1 which hadn't xz available.
>>
>> In commit 12745eaa02 Gerd updated the VM to OpenBSD 6.5 and we now have
>> access to xz. IIRC OSX supported versions also provide xz.
>>
>> If we want to revert Laszlo's patches and apply his first version (using
>> xz), we should do that during 5.0 dev cycle, now it is too late.
>> I'd prefer we simply fix bzip2 for the next release.
>=20
> I don't think we should try to use 'xz' because I don't see
> the point. We should use something that's generally available,
> whether that's bzip2 or gzip. Life's too short to deal with
> yet another file compression tool and format.

FWIW, on the weekend, I accidentially came accross this page:

 https://www.nongnu.org/lzip/xz_inadequate.html

After reading that, I also don't think anymore that we should switch to
'xz'.

 Thomas


