Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E1C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 10:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B91206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 10:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuSoicsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B91206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijKu2-0000CZ-E4
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 05:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ijKtP-0008CZ-9d
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 05:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ijKtM-0002Ru-Ke
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 05:24:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ijKtL-0002RA-Tt
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 05:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577096686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMO7zesGi+1fBP0Wbdr3Trjy6Js85XWu+NLJvHhvQwI=;
 b=RuSoicshoIa4g078vxyMbDmRdwVQXUq8ST+Tzwpk9jUOyK6oZgy/i0wGa9qP5UTrDRoXZW
 4PhAiw/kyh7aZHR0DD6tzcJBR0byiPGRnwtGJhvsUM8sQNRoK4+DQiEO8TpVZrE7/MnVdj
 WUU6TfHRoisE/jHRm9zij3Om6ICwzxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-bu8JpBwTN2qNPIKW9ssuAw-1; Mon, 23 Dec 2019 05:24:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2551107B2AA;
 Mon, 23 Dec 2019 10:24:40 +0000 (UTC)
Received: from redhat.com (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E8DA80AB4;
 Mon, 23 Dec 2019 10:24:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PULL 2/2] configure: Require Python >= 3.5
In-Reply-To: <20191220201258.GA498046@habkost.net> (Eduardo Habkost's message
 of "Fri, 20 Dec 2019 17:12:58 -0300")
References: <20191220165141.2207058-1-ehabkost@redhat.com>
 <20191220165141.2207058-3-ehabkost@redhat.com>
 <8736deakmn.fsf@trasno.org> <20191220201258.GA498046@habkost.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 23 Dec 2019 11:24:32 +0100
Message-ID: <87y2v38hlr.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bu8JpBwTN2qNPIKW9ssuAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: quintela@redhat.com
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Dec 20, 2019 at 07:59:28PM +0100, Juan Quintela wrote:
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > Python 3.5 is the oldest Python version available on our
>> > supported build platforms, and Python 2 end of life will be 3
>> > weeks after the planned release date of QEMU 4.2.0.  Drop Python
>> > 2 support from configure completely, and require Python 3.5 or
>> > newer.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
>> > Reviewed-by: John Snow <jsnow@redhat.com>
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>=20
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Thanks!
>
>>=20
>> But once here, a comment telling why we want 3.5, not 3.4 or 3.6 will
>> have been helpful.
>
> Is "Python 3.5 is the oldest Python version available on our
> supported build platforms" a good explanation why we want 3.5?

You have a point here O:-)

Later, Juan.


