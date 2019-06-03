Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B2C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6557523D13
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6557523D13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqy1-0004vh-EO
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:41:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1hXqxH-0004cG-KA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1hXqxE-0002T6-5X
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:41:05 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15]:55600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1hXqx2-0001kJ-AT
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:40:57 -0400
Received: from blackfin.pond.sub.org (p4FD0507F.dip0.t-ipconnect.de
	[79.208.80.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
	SHA256) (Client did not present a certificate)
	by oxygen.pond.sub.org (Postfix) with ESMTPSA id E617E3A0EA
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 19:40:32 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A2F7C11386A0; Mon,  3 Jun 2019 19:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
	<20190311220843.4026-23-armbru@redhat.com>
	<76d4a7b2-3c13-beea-2dc0-4fda7025030b@redhat.com>
	<878sv6tyjy.fsf@dusky.pond.sub.org>
	<ea01ee11-8888-444d-1f51-387dc73464f5@redhat.com>
Date: Mon, 03 Jun 2019 19:40:32 +0200
Message-ID: <87zhmysh2n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 94.130.129.15
Subject: Re: [Qemu-devel] [PULL 22/27] vl: Create block backends before
 setting machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I apologize for the delay, got distracted.

Michal Privoznik <mprivozn@redhat.com> writes:

> On 5/16/19 1:43 PM, Markus Armbruster wrote:
> <snip/>
>
>>> Actually, there is more problems with this. Trying to run a guest with
>>> persistent reservations fails after this patch is applied (git bisect
>>> points me to this commit). My command line is:
>>>
>>> qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
>>> -monitor stdio \
>>> -object pr-manager-helper,id=3Dpr-helper0,path=3D/tmp/pr-helper0.sock
>>> -drive
>>> file=3D/dev/mapper/crypt,file.pr-manager=3Dpr-helper0,format=3Draw,if=
=3Dnone,id=3Ddrive-scsi0-0-0-2
>>> \
>>> -device
>>> scsi-block,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D2,drive=3Ddrive-=
scsi0-0-0-2,id=3Dscsi0-0-0-2
>>>
>>> Honestly, I have no idea how to fix it, so I'm just raising this issue
>>> here. Do you want me to open a bug or something?
>>
>> Let's skip the bug filing bureaucracy and go straight to debugging.
>
> Agreed.
>
>>
>> Actual and expected behavior of your reproducer, please :)
>>
>
> Actual is that qemu fails to parse cmd line:
>
>
> qemu-system-x86_64: -drive
> file=3D/dev/mapper/crypt,file.pr-manager=3Dpr-helper0,format=3Draw,if=3Dn=
one,id=3Ddrive-scsi0-0-0-2:
> No persistent reservation manager with id 'pr-helper0'
>
>
> Which obviously is not correct, because pr-helper0 is specified.
> Expected result is that qemu suceeds in parsing the cmd line and
> starts the guest. To test it you don't need /dev/mapper/* really, I
> mean, if qemu fails with a different error message (e.g. it can't open
> the disk or EPERM or whatever), it's a sign it got past the cmd line
> parsing successfuly.

Reproduced, thanks!

Here's what happens.  Our general problem is that qemu-system-FOO's
main() acts on command line arguments in its own idiosyncratic order.
There's not much method to its madness.  Whenever we find a case where
one kind of command line argument needs to refer to something created
for another kind later, we rejigger the order.

Some time back, Dan Berrang=C3=A9 ran into an "impossible" instance of this
general problem: some kinds of -object get referenced by certain
character devices (therefore, -object must be acted on before character
devices), but other kinds of -object reference other character devices
(therefore, -object must be acted on after character devices).  He
solved the problem by sorting the -object into two buckets (commit
f08f9271bfe):

* Normal ones are created pretty early, so they can be referenced by
  (most) other things.

* Delayed ones are created pretty late, so they can reference (most)
  other things.

The pr-manager-helper object is a delayed one (commit 7c9e527659c).

Worked because block backends got created even after delayed objects:

    qemu_opts_foreach(qemu_find_opts("object"),
                      user_creatable_add_opts_foreach,
                      object_create_initial, &error_fatal);
    [...]
    qemu_opts_foreach(qemu_find_opts("object"),
                      user_creatable_add_opts_foreach,
                      object_create_delayed, &error_fatal);
    [...]
    configure_blockdev(&bdo_queue, machine_class, snapshot);

Commit cda4aa9a5a0 moved the configure_blockdev() up:

    qemu_opts_foreach(qemu_find_opts("object"),
                      user_creatable_add_opts_foreach,
                      object_create_initial, &error_fatal);
    [...]
    /*
     * Note: we need to create block backends before
     * machine_set_property(), so machine properties can refer to
     * them.
     */
    configure_blockdev(&bdo_queue, machine_class, snapshot);
    [...]
    qemu_opts_foreach(qemu_find_opts("object"),
                      user_creatable_add_opts_foreach,
                      object_create_delayed, &error_fatal);

Now file-posix property "pr-manager" can no longer reference a
pr-manager-helper object.  Regression.

If I make pr-manager-helper a normal object, it again can reference it.

Paolo, why is pr-manager-helper a delayed object?  Why this hunk of
commit 7c9e527659c:

    diff --git a/vl.c b/vl.c
    index 9bb5058c3a..a121a65731 100644
    --- a/vl.c
    +++ b/vl.c
    @@ -2893,7 +2893,8 @@ static int machine_set_property(void *opaque,
      */
     static bool object_create_initial(const char *type)
     {
    -    if (g_str_equal(type, "rng-egd")) {
    +    if (g_str_equal(type, "rng-egd") ||
    +        g_str_has_prefix(type, "pr-manager-")) {
             return false;
         }


