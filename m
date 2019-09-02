Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C569C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 22:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4295D20828
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AHTDyJUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4295D20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4uql-000838-CY
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 18:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4upa-0007Z1-Br
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 18:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4upY-0001cN-NY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 18:29:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:40191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4upX-0001bS-Vt
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 18:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5RQJgQwWFYKFJmJoB5t/p/OgzOgHujRzOXrkYHfYs10=; b=AHTDyJUdg9Eqn2/+XmwtUquHkW
 oJ2eAl6AFroWu6eTaRCz3xYhtAc9ltXrNwD7n3vPVZKu3DgTXt/XboAmbCE4drNqvHmpRQjbBIQ3d
 +/XkckZ45kT3vOGXVkxdEtaVjiwKiJHGFOH2xFxtl6+h2l6+H0+atxeYpt4d0Kc2JCDjVW9eOEce1
 WizPdNAKszvx4MsuI2wKhrtErOZWV2SQBND9Q2uxoldcQ02NHUMxNyaG7jH3YenvAifNJLVtoQCCY
 aQcS8UV30h5N1nVER5oMcTMiMXRpZzqMoISAobv/zGh7GsZAFFzeldntJ8bQX1Hw2onHR5lmEuvlv
 ZabTeSvsqim5ON6H/MoWeZhPCtSRGuXBwMjSt1BB0RN7/+6r1fwsad1skuWyWFKBiWC+W7vtI6q+Q
 kD0jO5zrgNSDLP4GFK3lYtvyhx04ysR7AXZyxggEhjPbkNrwpnDWaBQbawMvd7DN5cQ5JyIGl8wFs
 cULnW2ekxfY11GSZ5LDt6oasG2eoN2ifY9EiVj2hWaRMSjjCNOhXKecKInMJsGYPjCURTtGAuzAVA
 RztHUvHWpLnvCrUVwNsf2GMI/f0oEYo7Psc33zsD/fCj6b28GAV6pwwll2HgLclsmwj/LLstOuNyZ
 5T1pstac8iSbRHH2VRS/x9bDe06EIWf0ETCpWN67Q=;
To: qemu-devel@nongnu.org
Date: Tue, 03 Sep 2019 00:29:43 +0200
Message-ID: <2734436.Mu773bgsdE@silver>
In-Reply-To: <20190902173432.20f2637b@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: berrange@redhat.com, stefanha@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 dgilbert@redhat.com, antonios.motakis@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 2. September 2019 17:34:32 CEST Greg Kurz wrote:
> On Sun, 01 Sep 2019 21:28:45 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Donnerstag, 29. August 2019 19:02:34 CEST Greg Kurz wrote:
> > > On Thu, 22 Aug 2019 15:18:54 -0700 (PDT)
> > > 
> > > no-reply@patchew.org wrote:
> > > > Patchew URL:
> > > > https://patchew.org/QEMU/cover.1566503584.git.qemu_oss@crudebyte.com/
> > > > 
> > > > 
> > > > 
> > > > Hi,
> > > > 
> > > > This series seems to have some coding style problems. See output below
> > > > for
> > 
> > > > more information:
> > [snip]
> > 
> > > > === OUTPUT BEGIN ===
> > > > 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one
> > > > export
> > > > as an error) ERROR: Author email address is mangled by the mailing
> > > > list
> > > > #2:
> > > > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> > > 
> > > This is problematic since it ends up in the Author: field in git. Please
> > > find a way to fix that.
> > 
> > Like in which way do you imagine that? And where is the actual practical
> > problem? I mean every patch still has my signed-off-by tag with the
> > correct
> > email address ending up in git history.
> 
> Yes, this only breaks Author: if the patch is applied from the list.
> 
> > The cause for this issue is that the domain is configured to require DKIM
> > signatures for all outgoing emails. That's why mailman replaces my address
> > by "Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>"
> > placeholder since it could not provide a valid signature.
> > 
> > There were good reasons for enabling DKIM and it is a good thing for all
> > domains in general, since that ensures that (i.e. foreign) email addresses
> > cannot be used as sender address if the actual sender is not authorized
> > for
> > sending emails with that address.
> 
> Don't know much about DKIM but google seems to confirm what you say.

When you view the source of my emails you'll always see a "DKIM-Signature:" 
field in the email header, which is a signature of the email's body and the 
specific email header fields listed in the "DKIM-Signature:" block, so the 
original server can choose by itself which header fields to include ("h=...") 
for signing, but the standard requires the From: field must always be 
included.

A receiving server then obtains the public key from the domain's DNS records 
and checks if the DKIM signature of the email was correct:
https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail

Additionally the receiving server obtains the so called "DMARC" entry from the 
domain's DNS records. The "DMARC" DNS entry contains the domain's general 
policies how receiving email servers shall handle verification of emails of 
this domain. For instance the DMARC entry may list SMTP servers (e.g. IPs, DNS 
names) eligble to send emails on behalf of the domain at all, and it defines 
what receiving email servers shall do with emails which were identified of not 
being from an eligible source (e.g. sender IP not listed in DMARC entry or 
missing or wrong DKIM signature in email header). For instance if the policy 
is "quarantine" in the DMARC entry then receiving servers are advised to 
simply drop invalid emails:  https://en.wikipedia.org/wiki/DMARC

> So, this means that patchew will complain each time you post if we can't
> find a proper way to address that... :-\

Well, mailman is handling this correctly. It replaces the "From:" field with a 
placeholder and instead adds my actual email address as "Reply-To:" field. 
That's the common way to handle this on mailing lists, as also mentioned here:
https://en.wikipedia.org/wiki/DMARC#From:_rewriting

So IMO patchew should automatically use the value of "Reply-To:" in that case 
as author of patches instead.

Reducing security cannot be the solution.

> > What I changed in the meantime though is that you should get all my
> > patches
> > directly to your personal address, not only from the list. Or did you
> > receive v6 again just from the list?
> 
> I've received the patches in my mailbox but I prefer to use the patchwork's
> pwclient CLI to apply patches... and patchwork captures the patches from
> the list, so I end up having to patch the authorship manually anyway.
> 
> How are you sending patches ? With git send-email ? If so, maybe you can
> pass something like --from='"Christian Schoenebeck"
> <qemu_oss@crudebyte.com>'. Since this is a different string, git will
> assume you're sending someone else's patch : it will automatically add an
> extra From: made out of the commit Author as recorded in the git tree.

I use "git format-patch ..." to dump the invidiual emails as raw email sources 
and then I'll send those raw emails from the command line. So I have even more 
control of what is exactly sent out and could of course also add custom email 
header fields if required, if that would solve the situation somehow, i.e. 
manually as first test and later in automated way. That's not the issue here.

The problem however is that there is probably not any header field I could add 
that would solve the problem. Because I guess patchew is really just taking 
the first "From:" field as author, period.

I think the source files are available, so I could check that.

> > > Other warnings/errors should also be fixed but they look trivial.
> > 
> > Yeah, they are trivial. *But* there is one thing ...
> > 
> > > > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> > > > 
> > > > ERROR: space prohibited after that open parenthesis '('
> > > > #92: FILE: hw/9pfs/9p.c:586:
> > > > +    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
> > > > 
> > > > ERROR: space prohibited before that close parenthesis ')'
> > > > #98: FILE: hw/9pfs/9p.c:592:
> > > > +           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
> > > > 
> > > > ERROR: space prohibited before that close parenthesis ')'
> > > > #99: FILE: hw/9pfs/9p.c:593:
> > > > +           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
> > 
> > ... I would like to ignore this specific bot whining, because that
> > particular function looks much more readable the way it is (in that
> > patch) right now.
> Prettier certainly but...
> 
> /* Same as mirror8bit() just for a 64 bit data type instead for a byte. */
> static inline uint64_t mirror64bit(uint64_t value)
> {
>     return ((uint64_t)mirror8bit(value         & 0xff) << 56) |
>            ((uint64_t)mirror8bit((value >> 8)  & 0xff) << 48) |
>            ((uint64_t)mirror8bit((value >> 16) & 0xff) << 40) |
>            ((uint64_t)mirror8bit((value >> 24) & 0xff) << 32) |
>            ((uint64_t)mirror8bit((value >> 32) & 0xff) << 24) |
>            ((uint64_t)mirror8bit((value >> 40) & 0xff) << 16) |
>            ((uint64_t)mirror8bit((value >> 48) & 0xff) <<  8) |
>            ((uint64_t)mirror8bit((value >> 56) & 0xff));
> }
> 
> ... is readable enough IMHO and makes checkpatch happy :)

Well, okay :)



