Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675AC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1BB20795
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VExYhK6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1BB20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUKT-00084J-Sx
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIUA1-0002aR-Eo
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIU9z-0000yJ-8M
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600250129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWIPOnqIz9lGZzajeOIavy2KAekRiyHhPdyzOBp3yco=;
 b=VExYhK6M4VISw1yj0jCxF1Pks9l0cI90XM4eTCWPVrZRSDmZNQgRAw7AwzUIWa0vl13dKn
 DJtEddqKWHlO1cS573pk6/J9NltybQM9Q36DpqAWmARZSGsdhit6NBGcvM67YoeoyVw68e
 6gRvV8sB9Hkqm5DPywLSyClYkvGZ5Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-goxT9BiuPHG7MIKv0flhmQ-1; Wed, 16 Sep 2020 05:55:27 -0400
X-MC-Unique: goxT9BiuPHG7MIKv0flhmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 515811017DC1;
 Wed, 16 Sep 2020 09:55:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 645851974D;
 Wed, 16 Sep 2020 09:55:12 +0000 (UTC)
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <1ad049f0-09f9-d56f-bc63-d120a0dbcf24@redhat.com>
 <20200916083327.GE1535709@redhat.com>
 <91372bbf-bb36-2ade-c8a4-7e1f8b0776ea@redhat.com>
 <20200916095402.GI1535709@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ac642cb-a81f-97e6-9419-ebee2996fba4@redhat.com>
Date: Wed, 16 Sep 2020 11:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200916095402.GI1535709@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2020 11.54, Daniel P. Berrangé wrote:
> On Wed, Sep 16, 2020 at 11:50:06AM +0200, Thomas Huth wrote:
>> On 16/09/2020 10.33, Daniel P. Berrangé wrote:
>>> On Wed, Sep 16, 2020 at 09:54:32AM +0200, Thomas Huth wrote:
>>>> On 16/09/2020 09.43, Markus Armbruster wrote:
>>>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>>>> already does for its Python parts.
>>>>
>>>> I think the only reason for requiring Python 3.5 is that we still use
>>>> Ubuntu Xenial in Travis. We don't support Xenial according to our
>>>> support policy anymore, but we did not update to Bionic there since it
>>>> has that broken version of libssh.
>>>>
>>>> Fortunately, since a couple of weeks, Travis now supports Focal, too, so
>>>> once we switched our .travis.yml to use Focal, I think we could start
>>>> requiring Python 3.6.
>>>
>>> Note we really should not be constrained by what Travis provides as
>>> images. Travis images provide docker, so we can spawn our Travis
>>> jobs inside containers to get arbitrary linux distros. We did this
>>> for libvirt for a while until we switched to GitLab CI. So we
>>> definitely don't need to care about Xenial from a Travis POV no
>>> matter what.
>>
>> I hope we could finally exploit the possibility to use KVM on Travis ...
>> that won't be possible anymore once we use containers there.
> 
> Do they forbid passing the /dev/kvm device node into the docker
> container ? I would have though that would be allowed, since using
> KVM inside docker is no worse than using it outside docker in the
> Travis env.

Maybe ... I'm just a complete ignorant in this area ;-)

 Thomas


