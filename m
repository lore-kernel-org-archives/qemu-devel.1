Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97532C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7AA21775
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVHsmToE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7AA21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVq7S-0005YT-6l
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVq6j-0004uk-6h
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 01:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVq6g-0004Vk-4d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 01:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603432756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+oL5MZIPOI2OMwOOZWXdoCf4FgrhE27qbMcjT+J2giI=;
 b=cVHsmToEajmfcoMX8Aa0RGmSCQt/F+KIaaovK5+N7A6pkLNd4mppnynsNkqJI1rAryvKnn
 cqSbDyZZEPcSnHJRE+zd6mHCPpqrxK/bUr4jc7pxsSi0CFOwsplAt8qEHRTcueh48mci3H
 KIpymkUaAouNNpeXiip/DbYVfPvyn9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-O6PZidjtObGIBeHcpdYtSQ-1; Fri, 23 Oct 2020 01:59:12 -0400
X-MC-Unique: O6PZidjtObGIBeHcpdYtSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B1D41006CAB;
 Fri, 23 Oct 2020 05:59:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-123.ams2.redhat.com [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 895E41A8EC;
 Fri, 23 Oct 2020 05:59:01 +0000 (UTC)
Subject: Migrate Wiki to Gitlab? (was: Migrating custom qemu.org
 infrastructure to GitLab)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
Message-ID: <436a85e3-a6af-b344-fe04-26acf1dbcb38@redhat.com>
Date: Fri, 23 Oct 2020 07:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 12.22, Thomas Huth wrote:
> On 09/07/2020 12.16, Gerd Hoffmann wrote:
>>   Hi,
>>
>>>> 2. wiki.qemu.org is a MediaWiki instance. Account creation is a hurdle
>>>> to one-time or new contributors. It is unclear whether GitLab's wiki
>>>> is expressive enough for a lossless conversion of the existing QEMU
>>>> wiki. Any volunteers interested in evaluating the wiki migration would
>>>> be appreciated.
>>>
>>> Yeah, this is a potentially big piece of work. We didn't finish this
>>> in libvirt either. Looking at the libvirt mediawiki though, I decided
>>> not todo a straight export/import of all content.
>>
>> FYI: gitlab wiki is basically just a git repo with markdown pages +
>> renderer + gui editor.  You can also update the wiki using git clone +
>> edit + git commit + git push.
> 
> FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
> (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
> converted https://wiki.qemu.org/Contribute/MailingLists into
> https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
> few clicks.

Revisiting this topic after a couple of weeks, I think there is one more
thing to consider: If I've got that right, your account has to be a member
of the corresponding project to be able to edit a page in the Wiki in
gitlab. So unless we want to add lots of persons to the qemu-project as
members (which we likely do not really want, do we?), it's maybe better to
keep the separate MediaWiki instance with the separate user accounts, I guess?

 Thomas


