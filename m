Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD36C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CC72078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3HUbFOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CC72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8f6O-0000WG-VV
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8f5q-0008SY-M3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:34:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8f5o-00065I-6a
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597908874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJpQUZlO7tKiBQOn4lEYc/r1oJwFaGkZ8sKkn0++8lA=;
 b=T3HUbFOufNIT+cJPxIpru/zC4XCims07rXT5IT+6gLKA6eTae2QcE79tQpWrmr/c1PAIa2
 iM/DAywkIKW/NwoM++eEX2PMqgiF+/0Rc8n1z98nXxtOKKazu9LP9OHmG5nCi0hHCzk1Vx
 tLeNfNpJZauo3VC3GgRXoywUX9SKkzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-yLEBif8-Meq8aEyE0C61xQ-1; Thu, 20 Aug 2020 03:34:33 -0400
X-MC-Unique: yLEBif8-Meq8aEyE0C61xQ-1
Received: by mail-wm1-f70.google.com with SMTP id c124so642902wme.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pJpQUZlO7tKiBQOn4lEYc/r1oJwFaGkZ8sKkn0++8lA=;
 b=fJdNA8V3pafbe2WGBcmLVR0oIgy2tTnyYpF2NuQ0YbjaEogGFgtUlH5iJBwcg4fpKp
 4YLdewFUr/acQ8GLHDKB0O4zK5YOxabUJFSxQn4aXnZFBDlSrk+5bglm5O7IJvgqb3y9
 RFe7ACg5u3uW/2zyCMaoFcfTv/fInHUOM3QMUXzFJ5PqIrUb/lgIo2+wrpSh7Y195OuE
 IzF3ZYLiORgHJTA0ZhCJp5janpdN3aUU8QVnU2XOHhnqE3Un2lplzdjpDOgzr9UL+h7u
 d514pHOPvaY/8UbrL+Md69vOhNBVbLkYbMdV9bfROSu63ZAYI2RfRjsARjhZQSzZNhSJ
 Uh/w==
X-Gm-Message-State: AOAM5326j/yKywpaijhhmbEmUpNuRMvaRU5+jj4YyQtZXE7V4hTC2ysr
 keUSupT0lDhgEayXWS9nobLg/YUJ7GFzHLt9ytDzDYfQz5bye74SSMBUHmWGZSok8VSbTgRVwUb
 JriPzgK6ELkdw3BE=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr1748105wre.369.1597908871954; 
 Thu, 20 Aug 2020 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMAc/7Ko5h2l0g3MLVloq7WiFP9ewgm+svqk5ITPlrYgDrAsi2r+q0Fgu8cWOIxvltMJQ8KA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr1748081wre.369.1597908871702; 
 Thu, 20 Aug 2020 00:34:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id e16sm2504735wrx.30.2020.08.20.00.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 00:34:31 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] coroutines: generate wrapper code
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
 <20200727124840.GC386429@stefanha-x1.localdomain>
 <c610e7b2-9c1a-30fd-4217-e1bcb812ec7c@virtuozzo.com>
 <76c463e6-0d63-d25d-8095-e87db97c5081@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17034772-2b81-b8f9-1bfc-3ebdc6b07980@redhat.com>
Date: Thu, 20 Aug 2020 09:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <76c463e6-0d63-d25d-8095-e87db97c5081@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 03:33, Eric Blake wrote:
>>>
>>
>> OK, will do. Thanks for taking a look!
> 
> As this series touched Makefile to add a generated .c, you'll also need
> to rebase that part to apply on top of Paolo's meson conversion (cc'ing
> him if you need help figuring it out)

It should be trivial to do so using custom_target.

Paolo


