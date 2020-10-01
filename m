Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C50FC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B31207FB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9tDjDN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B31207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzao-00010h-Td
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNzZj-0000Ux-V2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNzZh-0000Qp-Hh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601562525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DSpBdH06BLyNKakHlN/LiGUS0LibMOVMxc/VUriZ7lI=;
 b=C9tDjDN13E1ssexCDMvl6zSHlb03ekSIjNx9gKwfID6W3iSN1W5xlOjTfn02Zf+OtDvxO+
 PimiBzmBZC1+wqJJuHOrKi9+hWJqNSIQXlw1oEnWF5nx+dHPMy/UAQAPVY7UPKi5MH5N0t
 OSg74RMCLUrVXdZ4S/uTkBVrAJz3EeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-IEQdicZ6MJWTfU-cD_BC4A-1; Thu, 01 Oct 2020 10:28:44 -0400
X-MC-Unique: IEQdicZ6MJWTfU-cD_BC4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F30FF907E8D;
 Thu,  1 Oct 2020 14:28:42 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DDCF73671;
 Thu,  1 Oct 2020 14:28:41 +0000 (UTC)
Subject: Re: [PATCH v4 04/46] qapi: modify docstrings to be sphinx-compatible
To: Markus Armbruster <armbru@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-5-jsnow@redhat.com>
 <87wo0bejmy.fsf@dusky.pond.sub.org>
 <4bb15cb7-ddcc-ae41-dcb8-81aaa7117ffa@redhat.com>
 <87a6x6498t.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c20ddc31-2d7a-bc83-ce4c-556441bd55ed@redhat.com>
Date: Thu, 1 Oct 2020 10:28:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a6x6498t.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 4:54 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/30/20 4:47 AM, Markus Armbruster wrote:
>>> Sadly, the fact that start_if() and end_if() are functions isn't
>>> immediately obvious anymore.
>>> I've seen :func:`start_if` elsewhere.  Is this something we should
>>> or
>>> want to use?
>>
>> Looks like `start_if()` works just fine too. If you are hard-set in
>> wanting to see those parentheses I can use this style, but admit I am
>> not likely to use them myself in newer docstrings, and there's no way
>> to enforce their presence OR absence that I am aware of.
> 
> Well, there's no way to enforce presence or absence of ` either, right?
> 

Yeah, just a warning that enforcing mechanical consistency along these 
lines is not something we can do at the moment.

(We maybe could by creating a sphinx plugin, but that's a bridge to 
cross much, much later. Anything is possible with time, engineers, and 
money, right?)

> Aside: checking the enclosed text resolves as a cross-reference could
> provide good-enough enforcement of absence, but enclosing stuff in `
> when you shouldn't is probably the lesser issue.
> 
>> I'll bake that change in for now until I see another reply.
> 
> Since this is a side show right now, consider the arguments raised so
> far, use your judgement, and move on to the main show.
> 

Keeping emails out of my inbox is presently the nicest thing :)

Thanks for looking.

--js


