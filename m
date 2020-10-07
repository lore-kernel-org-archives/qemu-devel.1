Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F83C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670572173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvHFZAF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670572173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEWn-0000AU-Ca
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQEUF-00073B-4J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQEUC-0002R2-MX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602096503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSeDEPU4NzcNNsmrwB5RFollXaCTClf1pmGLu2UVxng=;
 b=EvHFZAF5BPBJ05oJA6hn6yFua75Bplo8yGc05Vo3ozzUK+rdMpVzl2o8atoXF/0YY1IWFd
 ZzlLPL6huX6KW8qYSqCSaEAZhON1tGCmpCbI5qGunNeBFj5jt3P7R9lxa71Qc6fxP/p8Ap
 zFX3UD55XRonPp4TgA7Z2bKOWXUHPRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-bC1Md4cAPdW_nIRytAudHA-1; Wed, 07 Oct 2020 14:48:20 -0400
X-MC-Unique: bC1Md4cAPdW_nIRytAudHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FA4C1084D64;
 Wed,  7 Oct 2020 18:48:19 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAC0519C4F;
 Wed,  7 Oct 2020 18:48:18 +0000 (UTC)
Subject: Re: [PATCH 11/20] python/qemu: Add mypy type annotations
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-12-jsnow@redhat.com>
 <20201007104616.GE7212@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <399c97f7-ac22-c2ae-f438-e0114cc0251d@redhat.com>
Date: Wed, 7 Oct 2020 14:48:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007104616.GE7212@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 6:46 AM, Kevin Wolf wrote:
> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>> These should all be purely annotations with no changes in behavior at
>> all. You need to be in the python folder, but you should be able to
>> confirm that these annotations are correct (or at least self-consistent)
>> by running `mypy --strict qemu`.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> 'mypy --strict qemu' doesn't have clean output after this patch because
> ConsoleSocket isn't converted yet. But then, technically the commit
> message doesn't make this claim, and you can indeed check the
> self-consistency when you ignore the ConsoleSocket related errors, so
> probably not a problem.
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

Whoops, old commit message.

I decided against folding in the new changes because they are newer and 
have been through the review wringer a lot less.

I'll fix this commit message up.


