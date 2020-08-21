Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0222B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO6Gme5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0222B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BUD-0004ya-8e
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9BTa-0004Xj-Ka
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:09:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9BTW-0006m0-Gi
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598033353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+34apQ9s1Z1PGS3ewog4hEW9tXOJDY+6THYlLwIoY+o=;
 b=KO6Gme5wh1Qg/Jwl/BFx1ocods+ueMzixGeFVD1eQgcqwLiQ9BgUvjrbBLTNkwh9dbEcOE
 ZGxxDbPwAd/wcE0ECxw28529yMClYW3V3jo4y2H9dMNXSYdPgAeyG0Y/pwLVBDu2Nv0OPB
 2O+Sc66GxMcqbYHOQjsqKTqZJu59Qa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-pC-oKG-rMZyzYcA3LdCweA-1; Fri, 21 Aug 2020 14:09:07 -0400
X-MC-Unique: pC-oKG-rMZyzYcA3LdCweA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA651007469;
 Fri, 21 Aug 2020 18:09:06 +0000 (UTC)
Received: from [10.3.113.76] (ovpn-113-76.phx2.redhat.com [10.3.113.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67CD37C53A;
 Fri, 21 Aug 2020 18:09:03 +0000 (UTC)
Subject: Re: [PATCH] configure: silence 'shift' error message in version_ge()
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20200821150014.42461-1-sgarzare@redhat.com>
 <CAFEAcA9zUDeig8TB4JDd_48v2AXcr7HGyjGq6r7KVx=sQyrjXA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <88a7a480-fe70-68fe-4422-6020070045c3@redhat.com>
Date: Fri, 21 Aug 2020 13:09:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zUDeig8TB4JDd_48v2AXcr7HGyjGq6r7KVx=sQyrjXA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 10:21 AM, Peter Maydell wrote:
> On Fri, 21 Aug 2020 at 16:00, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> If there are less than 2 arguments in version_ge(), the second shift
>> prints this error:
>>      ../configure: line 232: shift: shift count out of range
>>
>> Let's shut it up, since we're expecting this situation.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 4e5fe33211..de4bd0df36 100755
>> --- a/configure
>> +++ b/configure
>> @@ -229,7 +229,7 @@ version_ge () {
>>           set x $local_ver1
>>           local_first=${2-0}
>>           # shift 2 does nothing if there are less than 2 arguments
>> -        shift; shift
>> +        shift; shift 2>/dev/null
> 
> POSIX says
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#shift
> 
> "If the n operand is invalid or is greater than "$#", this may be
> considered a syntax error and a non-interactive shell may exit"
> 
> so I think that we need to actually avoid the excess shift,
> not just suppress any warning it might print. (I'm not sure
> Philippe's "shift || shift" patch can work for that, though,
> as the exit status doesn't distinguish "valid shift but don't
> do it again" from "valid shift and more args to come".)

Indeed.  'shift || shift' is not going to work.  'shift; shift 
2>/dev/null' is risky, as it can cause the shell to exit.  But this does 
exactly what you want:

shift ${2:+2}

which works out to 'shift 2' if $2 is set, or 'shift' (implicitly shift 
1) if $2 is not set.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


