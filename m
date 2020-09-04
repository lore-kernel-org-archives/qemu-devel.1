Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B7CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12158206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12158206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE65Z-0007qn-A0
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kE650-0007CW-Rc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:24:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kE64y-0004oS-E9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:24:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-QLO0Uy5LOluJH6lzz4Mdvg-1; Fri, 04 Sep 2020 03:24:09 -0400
X-MC-Unique: QLO0Uy5LOluJH6lzz4Mdvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662E42FD04;
 Fri,  4 Sep 2020 07:24:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5695C196FD;
 Fri,  4 Sep 2020 07:24:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CED801132B59; Fri,  4 Sep 2020 09:24:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
 <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
Date: Fri, 04 Sep 2020 09:24:03 +0200
In-Reply-To: <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com> (Paolo
 Bonzini's message of "Thu, 3 Sep 2020 19:55:14 +0200")
Message-ID: <87a6y6dmy4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/09/20 17:49, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
>>> On 03/09/20 17:35, Bruce Rogers wrote:
>>>> Turn on the meson install flag for these executables
>>>>
>>>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>>>> ---
>>>>  contrib/ivshmem-client/meson.build | 2 +-
>>>>  contrib/ivshmem-server/meson.build | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-clie=
nt/meson.build
>>>> index 1b171efb4f..83a559117f 100644
>>>> --- a/contrib/ivshmem-client/meson.build
>>>> +++ b/contrib/ivshmem-client/meson.build
>>>> @@ -1,4 +1,4 @@
>>>>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
>>>>             dependencies: glib,
>>>>             build_by_default: targetos =3D=3D 'linux',
>>>> -           install: false)
>>>> +           install: true)
>>>> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-serv=
er/meson.build
>>>> index 3a53942201..a1c39aa3b3 100644
>>>> --- a/contrib/ivshmem-server/meson.build
>>>> +++ b/contrib/ivshmem-server/meson.build
>>>> @@ -1,4 +1,4 @@
>>>>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
>>>>             dependencies: [qemuutil, rt],
>>>>             build_by_default: targetos =3D=3D 'linux',
>>>> -           install: false)
>>>> +           install: true)
>>>>
>>>
>>> They weren't installed before the conversion, were they?
>>=20
>> Unfortunately they were historically installed with --enable-tools.
>>=20
>> IMHO nothing in contrib/ should be installed by default. If we consider
>> something maintained and high enough quality for end users, it should
>> migrate out of contrib/ into tools/.
>
> Ah, via the tools variable in configure.  Nice maze.  I've queued the pat=
ch.

Please don't.

These programs are examples to help people understand how the ivhsmem
device works.  They might even be useful for debugging.  They are *not*
to be used in production.

docs/specs/ivshmem-spec.txt:

    Example server code is in contrib/ivshmem-server/.  Not to be used in
    production.  It assumes all clients use the same number of interrupt
    vectors.

    A standalone client is in contrib/ivshmem-client/.  It can be useful
    for debugging.

Installing example *source* might make sense (but I doubt it).
Installing the binaries does not.


