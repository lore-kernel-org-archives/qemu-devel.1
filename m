Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70696C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C792145D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E71TaWJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C792145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQU45-0003XX-Pl
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQU30-0002sT-8L
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQU2w-0004jk-4g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602156315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLVbJoBsPDuXxbNbiQkVMNBGGNNH1wdPLFoAiUHlzkc=;
 b=E71TaWJKySWXOHa/1ZhKlVihL9iRqT609JW9Nsj4khWooZSDLKiGpO9SDl8tGxGsOWmK82
 Ij+9Yn251UtltwffcnQ5eDbmPb9JCmIr8N6Ln0PDloqGZcuxkeY5SjgAOoq61hM5voPZN/
 Q8gLnVFvzRqLXSEgRgiOHpJjL6zuUQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-OP9GAm0gMumemyRtkFJ9eQ-1; Thu, 08 Oct 2020 07:25:12 -0400
X-MC-Unique: OP9GAm0gMumemyRtkFJ9eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1C310BBEC3;
 Thu,  8 Oct 2020 11:25:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3853719D7C;
 Thu,  8 Oct 2020 11:25:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77ED011329C1; Thu,  8 Oct 2020 13:25:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: KVM call for agenda for 2020-10-06
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
 <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
 <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
 <20201007180429.GI2505881@redhat.com>
Date: Thu, 08 Oct 2020 13:25:08 +0200
In-Reply-To: <20201007180429.GI2505881@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Wed, 7 Oct 2020 19:04:29 +0100")
Message-ID: <87h7r5yn6z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 07, 2020 at 07:50:20PM +0200, Paolo Bonzini wrote:
>> On 06/10/20 20:21, Stefan Hajnoczi wrote:
>> >     * Does command-line order matter?
>> >         * Two options: allow any order OR left-to-right ordering
>> >         * Andrea Bolognani: Most users expect left-to-right ordering,
>> > why allow any order?
>> >         * Eduardo Habkost: Can we enforce left-to-right ordering or do
>> > we need to follow the deprecation process?
>> >         * Daniel Berrange: Solve compability by introducing new
>> > binaries without the burden of backwards compability
>>=20
>> I think "new binaries" shouldn't even have a command line; all
>> configuration should happen through QMP commands.  Those are naturally
>> time-ordered, which is equivalent to left-to-right, and therefore the
>> question is sidestepped.  Perhaps even having a command line in
>> qemu-storage-daemon was a mistake.
>
> Non-interactive configuration is a nice property for simpler integration
> use cases. eg launching from the shell is tedious with QMP compared to
> CLI args.

Yes.

CLI, config file and QMP are differently convenient for different use
cases.

When you want to tweak just a few things for a single run, or a few in a
row, nothing beats the CLI.

A bespoke, long-lived configuration you really want to keep in a file.

When you use a program to run QEMU, and that program does QMP anyway,
doing *everything* in QMP can be just what you want.

If we could afford just one of the three, we'd probably want to pick
QMP, because it's the most flexible (it's supports queries naturally),
and because picking something else can't eliminate QMP.  Fortunately, we
don't have to pick just one if we base on initial configuration on QAPI.

A QMP command is "send an instance of a QAPI type to QEMU, get an
instance of a QAPI type or an error back".

A CLI option or configuration file entry is the same with the return
type constrained to "nothing".

The hard part is designing the QAPI type and putting it to use in QEMU.
Wrapping it in a QMP command is utterly trivial.

Wrapping it in a CLI option is no harder (we've done it a few times).
Right now, it takes some boilerplate.  We can eliminate the boilerplate
the exact same way we did for QMP commands: generate it.

Wrapping a bunch of QAPI types in a configuration file format is a bit
more work, mostly because the bikeshed will need a coat of paint.

> This could be addressed though by having a configuration file to load
> config from, where the config entries can be mapped 1-1 onto QMP commands,
> essentially making the config file a non-interactive QMP.
>
>> The big question to me is whether the configuration should be
>> QAPI-based, that is based on QAPI structs, or QMP-based.  If the latter,
>> "object-add" (and to a lesser extent "device-add") are fine mechanisms
>> for configuration.  There is still need for better QOM introspection,
>> but it would be much simpler than doing QOM object creation via QAPI
>> struct, if at all possible.

object-add and device-add are the last two genuine users of 'gen': false
(query-qmp-schema does it out of laziness, and my "Configurable policy
for handling deprecated interfaces" series makes it stop).

I'd like to take a serious swing at QAPIfying them, with a loose schema.
Good enough for QAPI-based initial configuration interfaces.  Not good
enough for introspection, but a better QOM introspection could fill that
gap.


