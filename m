Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25577C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDE22177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/qZxWza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDE22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zsr-0000aL-70
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2zsG-0008U3-LU
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:33:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2zsE-0001Y3-5F
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596558789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6P2KTmnO/M873KfBMLP25gdvZRXYvJKjGkN6tTdKO80=;
 b=P/qZxWzazzI0WlDbOxuKTzn1QEWf7+8x/ZbVYUcWK1fu4jyXuYwRDOmn6LdaC+Sdxdyi8r
 DURZL7DH+BJaj2aOKtCGYukAs0hBAINvjThKGjkSlpoFv0Nke7SafbCDOEFWy9C0U7mT2/
 +RLrEqHLFHp8EKH8QSEoG0z08/HMhAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-iuT3UYuXM6-PyMiEmk8dAw-1; Tue, 04 Aug 2020 12:33:01 -0400
X-MC-Unique: iuT3UYuXM6-PyMiEmk8dAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9F41005504;
 Tue,  4 Aug 2020 16:33:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C087919C71;
 Tue,  4 Aug 2020 16:32:54 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] gitlab-ci: Fix Avocado cache usage
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200730141326.8260-1-thuth@redhat.com>
 <20200730141326.8260-5-thuth@redhat.com> <877dueml9w.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <48e7ef9e-12b9-a970-9fb7-70f87b126fd6@redhat.com>
Date: Tue, 4 Aug 2020 18:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <877dueml9w.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/2020 18.24, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> In commit 6957fd98dc ("gitlab: add avocado asset caching") we
>> tried to save the Avocado cache (as in commit c1073e44b4 with
>> Travis-CI) however it doesn't work as expected. For some reason
>> Avocado uses /root/avocado_cache/ which we can not select later.
>>
>> Manually generate a Avocado config to force the use of the
>> current job's directory.
>>
>> This patch is based on an earlier version from Philippe Mathieu-Daudé.
> 
> Maybe add a Based-on: <msgid>?

Isn't that tag rather used for expressing dependencies between patch
series? See
https://wiki.qemu.org/Contribute/SubmitAPatch#Base_patches_against_current_git_master
?

>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .gitlab-ci.yml | 25 +++++++++++++++++++------
>>  1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index e96bcd50f8..9820066379 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -47,11 +47,24 @@ include:
>>      - find . -type f -exec touch {} +
>>      - make $MAKE_CHECK_ARGS
>>  
>> -.post_acceptance_template: &post_acceptance
>> +.acceptance_template: &acceptance_definition
>> +  cache:
>> +    key: "${CI_JOB_NAME}-cache"
>> +    paths:
>> +      - ${CI_PROJECT_DIR}/avocado-cache
>> +    policy: pull-push
>> +  before_script:
>> +    - mkdir -p ~/.config/avocado
>> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
>> +    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado-cache']"
>> +           >> ~/.config/avocado/avocado.conf
> 
> I was hoping there was a neater way to do this with the multiline
> commands but whatever:

I'm still fighting YAML syntax when it comes to such cases ... so I'm
open to suggestions!

> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks a lot!

 Thomas



