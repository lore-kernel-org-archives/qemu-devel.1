Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E198C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220D820838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8DgnOpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ePN-0007Qm-Bt
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j6eOa-0006TK-Vp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j6eOZ-00039o-EV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:53:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j6eOZ-00037j-Ag
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582653202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdgS3rUJKk3qmRnaRSr9lS17MlFo1xlNLW+kmRxR+70=;
 b=D8DgnOpCOawVWUC1Kci2r0sFE2Hg5MUSWErptOmYOOgYv+IvCDcytefLPYgB+b/6Z2h+0Y
 HONa7Kszb+whXDRw/9VZSlj7blv+eUE0G/5jwZQ5faGoYR4XdRytt1DEMHQ6JGKNv0gKHt
 HT0YQfD1VUkpCeLZTjA+BwnS2q/N1Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-zFviWNQ1Pw-Y7HKNkVpiSA-1; Tue, 25 Feb 2020 12:53:13 -0500
X-MC-Unique: zFviWNQ1Pw-Y7HKNkVpiSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3782801E67;
 Tue, 25 Feb 2020 17:53:11 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-104.ams2.redhat.com
 [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6BE48B759;
 Tue, 25 Feb 2020 17:53:09 +0000 (UTC)
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
To: wuchenye1995 <wuchenye1995@gmail.com>
Message-ID: <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
Date: Tue, 25 Feb 2020 18:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200224152810.GX635661@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: berrange@redhat.com, devel@edk2.groups.io, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhoujianjay <zhoujianjay@gmail.com>, discuss <discuss@edk2.groups.io>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/24/20 16:28, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 11, 2020 at 05:39:59PM +0000, Alex Benn=C3=A9e wrote:
>>
>> wuchenye1995 <wuchenye1995@gmail.com> writes:
>>
>>> Hi all,
>>>    We found a problem with live migration of UEFI virtual machines
>>>    due to size of OVMF.fd changes.
>>>    Specifically, the size of OVMF.fd in edk with low version such as
>>>    edk-2.0-25 is 2MB while the size of it in higher version such as
>>>    edk-2.0-30 is 4MB.
>>>    When we migrate a UEFI virtual machine from the host with low
>>>    version of edk2 to the host with higher one, qemu component will
>>>    report an error in function qemu_ram_resize while
>>> checking size of ovmf_pcbios: Length mismatch: pc.bios: 0x200000 in
>>> !=3D 0x400000: Invalid argument.
>>>    We want to know how to solve this problem after updating the
>>>    version of edk2.
>>
>> You can only migrate a machine that is identical - so instantiating a
>> empty machine with a different EDK image is bound to cause a problem
>> because the machines don't match.
>
> I don't believe we are that strict for firmware in general. The
> firmware is loaded when QEMU starts, but that only matters for the
> original source host QEMU. During migration, the memory content of the
> original firmware will be copied during live migration, overwriting
> whatever the target QEMU loaded off disk. This works....provided the
> memory region is the same size on source & target host, which is where
> the problem arises in this case.
>
> If there's a risk that newer firmware will be larger than old firmware
> there's only really two options:
>
>   - Keep all firmware images forever, each with a unique versioned
>     filename. This ensures target QEMU will always load the original
>     smaller firmware
>
>   - Add padding to the firmware images. IOW, if the firmware is 2 MB,
>     add zero-padding to the end of the image to round it upto 4 MB
>     (whatever you anticipate the largest size wil be in future).
>
> Distros have often taken the latter approach for QEMU firmware in the
> past. The main issue is that you have to plan ahead of time and get
> this padding right from the very start. You can't add the padding
> after the fact on an existing VM.

Following up here *too*, just for completeness.

The query in this thread has been posted three times now (and I have
zero idea why). Each time it generated a different set of responses. For
completes, I'm now going to link the other two threads here (because the
present thread seems to have gotten the most feedback).

To the OP:

- please do *NOT* repost the same question once you get an answer. It
  only fragments the discussion and creates confusion. It also doesn't
  hurt if you *confirm* that you understood the answer.

- Yet further, if your email address has @gmail.com for domain, but your
  msgids contain "tencent", that raises some eyebrows (mine for sure).
  You say "we" in the query, but never identify the organization behind
  the plural pronoun.

(I've been fuming about the triple-posting of the question for a while
now, but it's only now that, upon seeing how much work Dan has put into
his answer, I've decided that dishing out a bit of netiquette would be
in order.)

* First posting:
- msgid:      <tencent_F1295F826E46EDFF3D77812B@qq.com>
- edk2-devel: https://edk2.groups.io/g/devel/message/54146
- qemu-devel: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg0241=
9.html

  * my response:
    - msgid:      <12553.1581366059422195003@groups.io>
    - edk2-devel: https://edk2.groups.io/g/devel/message/54161
    - qemu-devel: none, because (as an exception) I used the stupid
                  groups.io web interface to respond, and so my response
                  never reached qemu-devel

* Second posting (~4 hours after the first)
- msgid:      <tencent_3CD8845EC159F0161725898B@qq.com>
- edk2-devel: https://edk2.groups.io/g/devel/message/54147
- qemu-devel: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg0241=
5.html

  * Dave's response:
    - msgid:      <20200220154742.GC2882@work-vm>
    - edk2-devel: https://edk2.groups.io/g/devel/message/54681
    - qemu-devel: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg=
05632.html

* Third posting (next day, present thread) -- cross posted to yet
  another list (!), because apparently Dave's feedback and mine had not
  been enough:
- msgid:        <tencent_BC7FD00363690990994E90F8@qq.com>
- edk2-devel:   https://edk2.groups.io/g/devel/message/54220
- edk2-discuss: https://edk2.groups.io/g/discuss/message/135
- qemu-devel:   https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02=
735.html

Back on topic: see my response again. The answer is, you can't solve the
problem (specifically with OVMF), and QEMU in fact does you service by
preventing the migration.

Laszlo


