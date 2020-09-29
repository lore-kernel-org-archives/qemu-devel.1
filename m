Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B745C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F0B20757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyXtNg32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F0B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFUP-0001pE-OM
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFQm-0006Fs-Hl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFQj-0005WD-UZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601385149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHIYL9jcqPkDBb38xKqQlZ6LW2YgqIK9pnW+fJMF89E=;
 b=MyXtNg32MUDC6j47dB/fiYM/38TEhfTtKzQvHN3ElumreLObTUWwnWQnp3WS+Vd2YTN7EA
 XS2y3oloKyGWmml/4XQ9/co6bCXnOYP+kkmeZkIePuRPik/y5gmqId47kcbOwXpZVXMoCz
 Zr+6ELgIcSQ8nmhfgLaWpKZd3Nw3pOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-WRfsUplOOByDlmNzuHzNbg-1; Tue, 29 Sep 2020 09:12:27 -0400
X-MC-Unique: WRfsUplOOByDlmNzuHzNbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30EA818BA29E;
 Tue, 29 Sep 2020 13:12:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0243B81C45;
 Tue, 29 Sep 2020 13:12:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91E32113864A; Tue, 29 Sep 2020 15:12:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 09/21] docs/interop: Convert qemu-qmp-ref to rST
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-10-peter.maydell@linaro.org>
 <87a6x90yy8.fsf@dusky.pond.sub.org>
 <CAFEAcA9RauKyN2XfECOwqhT02FsmZdxbQkRa89=QGcq+z0Oorw@mail.gmail.com>
Date: Tue, 29 Sep 2020 15:12:24 +0200
In-Reply-To: <CAFEAcA9RauKyN2XfECOwqhT02FsmZdxbQkRa89=QGcq+z0Oorw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 29 Sep 2020 10:41:01 +0100")
Message-ID: <87ft70sp53.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 29 Sep 2020 at 09:28, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > diff --git a/qapi/meson.build b/qapi/meson.build
>> > index 2b2872a41d8..a287ca5d9d7 100644
>> > --- a/qapi/meson.build
>> > +++ b/qapi/meson.build
>> > @@ -97,7 +97,7 @@ foreach module : qapi_all_modules
>> >  endforeach
>> >
>> >  qapi_files = custom_target('shared QAPI source files',
>> > -  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs + ['qapi-doc.texi'],
>> > +  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
>> >    input: [ files('qapi-schema.json') ],
>> >    command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
>> >    depend_files: [ qapi_inputs, qapi_gen_depends ])
>> > @@ -121,5 +121,3 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
>> >    specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
>> >    i = i + 1
>> >  endforeach
>> > -
>> > -qapi_doc_texi = qapi_files[i]
>>
>> Doesn't storage-daemon/qapi/meson.build need a similar update?
>
> I was previously unaware of storage-daemon/qapi...
> It looks like we don't actually do anything with the generated
> qapi-doc.texi there, so I'm not sure why we were listing it as an output.
> I think we should only need to remove the " + ['qapi-doc.texi']"
> in storage-daemon/qapi/meson.build, and that should be a separate
> change after this one and before we remove scripts/qapi/doc.py.

I'll give it a try.


