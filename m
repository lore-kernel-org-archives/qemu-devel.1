Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CAB22287
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCqG8YFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CAB22287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYui-0006Y5-FF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYsa-0004sN-Pn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYsZ-0001K0-5X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600268270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSlDs4O+r6p9B4CuYAIrFR1u49oiuhLHsVwAEIQr4yc=;
 b=DCqG8YFqE8jqJkZSzduHY08eO5/bOn/T5srj9yKG7w0uRwD7byMj2HHDH+YtqtR3JYnfGb
 W/Y9TFUW6+/Z9DdH8xnpRGvMd5wo8/YjeZPwbviFm9PeNcrTkjt1/pYG+7OjAUzWsdhR5M
 X9m02soCfqkZR3ucDjsRqr+fdq80u80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-1aghf2c5Oyimqyx1_nk4Vg-1; Wed, 16 Sep 2020 10:57:43 -0400
X-MC-Unique: 1aghf2c5Oyimqyx1_nk4Vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 186D3107B79C;
 Wed, 16 Sep 2020 14:57:39 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F30BC7DA54;
 Wed, 16 Sep 2020 14:57:37 +0000 (UTC)
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3e3bbd65-314b-7b55-6066-8ac3e259865a@redhat.com>
Date: Wed, 16 Sep 2020 10:57:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 10:00 AM, Thomas Huth wrote:
> On 16/09/2020 14.30, Peter Maydell wrote:
>> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>> already does for its Python parts.
> [...]
>> The default should be
>> "leave the version dependency where it is", not "bump the version
>> dependency as soon as we can".
> 
> OTOH, if none of our supported build systems uses python 3.5 by default
> anymore, it also will not get tested anymore, so bugs might creep in,
> which will of course end up in a bad experience for the users, too, that
> still try to build with such an old version. So limiting the version to
> the level that we also test is IMHO very reasonable.
> 
> Let's have a look at the (older) systems that we support and the python
> versions according to repology.org:
> 
> - RHEL7 / CentOS 7 : 3.6.8
> - Ubuntu 18.04 (Bionic) : >= 3.6.5
> - openSUSE Leap 15.0 : >= 3.6.5
> - OpenBSD Ports : >= 3.7.9
> - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
> - Homebrew : >= 3.7.9
> 
> ... so I think it should be fine to retire 3.5 nowadays.
> 
>   Thomas
> 

Thanks for researching this! I am going to transplant this into my 
commit message in my QAPI typing series.

Thank you very much!

--js


