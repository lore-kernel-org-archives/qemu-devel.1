Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC0DC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D924206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJCZcWak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D924206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPs16-0005Yw-95
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrzv-0004gX-Ur
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrzs-0008Jc-Nl
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602010055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3BgmtmVZtC6OD5dDU313/fWVDPz3+h8v8GpfL93hqg=;
 b=JJCZcWake0moM6cieKDMeRk9uNdr4rWyJADpZ11XfEgFCVQ/arpuLjoSps+4jz1tB6QAVs
 u0K++eo/H5JtJSTnwnPAdnIazokKVJBDHVKYJuaFf1NG5BVVNQ+2xOpoxuA3NJRv0+/GK5
 C623IlvOxuR0QvMqavUX8hfoWfA4CpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-w8vP9TkVMayC1paCwCS2AQ-1; Tue, 06 Oct 2020 14:47:33 -0400
X-MC-Unique: w8vP9TkVMayC1paCwCS2AQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631B11074651;
 Tue,  6 Oct 2020 18:47:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E68D95D9F1;
 Tue,  6 Oct 2020 18:47:30 +0000 (UTC)
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
 <CAFEAcA97upqUtasSsg+wxLFvak5rz+t3DBD7zMu4dnwvpw73AQ@mail.gmail.com>
 <20201006144215.GK2482221@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <deb55fbb-637b-0b94-6efb-c508c5dc691a@redhat.com>
Date: Tue, 6 Oct 2020 20:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201006144215.GK2482221@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/2020 16.42, Daniel P. Berrangé wrote:
> On Tue, Oct 06, 2020 at 03:38:56PM +0100, Peter Maydell wrote:
>> On Tue, 6 Oct 2020 at 15:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>
>>> On Tue, Oct 06, 2020 at 03:03:57PM +0100, Peter Maydell wrote:
>>>> Compile failure on OSX:
>>>>
>>>> ../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
>>>> char' but the argument has type 'int' [-Werror,-Wformat]
>>>>                     node->level - 1);
>>>>                     ^~~~~~~~~~~~~~~~
>>>> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
>>>> expanded from macro 'error_setg'
>>>>                          (fmt), ## __VA_ARGS__)
>>>>                           ~~~      ^~~~~~~~~~~
>>>> 1 error generated.
>>>
>>> Is there a CI system where this is tested?  I'd like to be able
>>> to detect this kind of failure before sending pull requests.
>>
>> Currently this is still my ad-hoc setup. I think there is
>> some CI that tests OSX compiles, though I have no idea how
>> individual maintainers set up to use it.
> 
> Cirrus CI will cover macOS builds.  You just need to register with
> Cirrus CI via your GitLab login, then pushing a branch to gitlab
> should trigger both GitLab CI and Cirrus CI, which covers a vast
> majority of combinations.

I think Cirrus-CI needs a github account? Is there a way to use Gitlab now 
instead? (just like Travis recently added Gitlab support?)

We should eventually set up the cirrus-run tool, so we can use gitlab, too, 
but I think you then still need at least a dummy github account to be able 
to use it, don't you?

  Thomas


