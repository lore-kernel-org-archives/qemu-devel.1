Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E866C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256D32070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLrlrv3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256D32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrQZ-0003Sd-Be
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyrQ0-00033I-BW
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:42:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyrPy-0008Ui-1w
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595572972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDXolUxnIEPi1SnhoKqQkVA4WR040LgyDb1xUOtcFoc=;
 b=KLrlrv3+z5BY0f9TreJLQWrW/sC3QDTKEV7qqY7qNYj1ZNeBv5sK63nSqx0l1hAWiwIWb1
 BPC9XUKRcyv/75FiI7LzrirLi7qqvik/itGt7EW7Be4Z61Ib2HvJynopOPZ1rjCA+UVcfc
 aexeHkuuyEjzoe9H9dwwmlKbkOC965w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-o0TCz9bqMY25LB7gCn1BzQ-1; Fri, 24 Jul 2020 02:42:51 -0400
X-MC-Unique: o0TCz9bqMY25LB7gCn1BzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AEA57;
 Fri, 24 Jul 2020 06:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3B4D71D00;
 Fri, 24 Jul 2020 06:42:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5017B111CA26; Fri, 24 Jul 2020 08:42:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH for-5.1 2/2] tpm: Improve help on TPM types when none are
 available
References: <20200723115845.1865886-1-armbru@redhat.com>
 <20200723115845.1865886-3-armbru@redhat.com>
 <45421f31-caf0-7f7f-de60-bf55b4c5c431@linux.ibm.com>
Date: Fri, 24 Jul 2020 08:42:48 +0200
In-Reply-To: <45421f31-caf0-7f7f-de60-bf55b4c5c431@linux.ibm.com> (Stefan
 Berger's message of "Thu, 23 Jul 2020 20:56:19 -0400")
Message-ID: <87mu3pe7mf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 7/23/20 7:58 AM, Markus Armbruster wrote:
>> Help is a bit awkward when no TPM types are built into QEMU:
>>
>>      $ upstream-qemu -tpmdev nonexistent,id=tpm0
>
> I hope you don't mind me replacing 'upstream-qemu' with
> 'x86_64-softmmu/qemu-system-x86_64'?
>
>>      upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
>
>
> and this one with 'qemu-system-x86_64:'
>
>
>>      Supported TPM types (choose only one):
>>
>> Improve to
>>
>>      upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
>>      No TPM backend types are available'
>
>
> I hope you don't mind me replacing 'upstream-qemu' with
> 'x86_64-softmmu/qemu-system-x86_64'?

On the contrary!  I meant to replace by qemu-system-x86_64 (no directory
part), but forgot.

Thanks!


