Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE1D22D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE1D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fsf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5EDc-0002xe-CE
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <iank@fsf.org>) id 1i5ECs-0002Uk-G8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:11:12 -0400
Received: from mail.fsf.org ([209.51.188.13]:40668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <iank@fsf.org>) id 1i5ECs-0002ks-7f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:11:10 -0400
Received: from mail.iankelling.org ([72.14.176.105]:39556)
 by mail.fsf.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.69) (envelope-from <iank@fsf.org>)
 id 1i5ECr-0003Sq-Ho; Tue, 03 Sep 2019 15:11:09 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
 (envelope-from <iank@fsf.org>)
 id 1i5ECq-00015k-AR; Tue, 03 Sep 2019 15:11:08 -0400
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver>
User-agent: mu4e 1.1.0; emacs 27.0.50
From: Ian Kelling <iank@fsf.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
In-reply-to: <2734436.Mu773bgsdE@silver>
Date: Tue, 03 Sep 2019 15:11:08 -0400
Message-ID: <87r24xqjoz.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Subject: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
Cc: berrange@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Greg Kurz <groug@kaod.org>, antonios.motakis@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At FSF, we've been working on this issue recently. I was planning to
send a general message to qemu-devel, but someone brought it up in a
thread below, so I'm doing it now.

Currently, a message sent to qemu-devel from a domain that publishes a
strict DMARC policy gets what mailman calls "Munge From". For example,
for a message sent to the list:

From: Anne Example Person <exampleperson@examplepersonsdomain>

Is modified my Mailman and sent to subscribers as:

From: Anne Example Person via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Anne Example Person <exampleperson@examplepersonsdomain>

We've recently made possible an alternative solution that does not need
munging and I call the unmodified message fix. Currently, mailman adds
"[Qemu-devel] " to the subject of messages. Modifying the message breaks
DKIM message signature and thus DMARC. In short: turn that off, and we
can stop from munging. Many lists are already this way, including most
popular @gnu and @nongnu lists, and this week we are doing a mass
conversion of lists which never touched DMARC related list settings (not
qemu-devel). Instead of using the subject prefix to identify a list,
subscribers can use the List-Id, To, and Cc headers.  List information
can also be be put in the welcome email to subscribers and the list
information page by list administrators.

Without going into all of the details, here's a few points about why we
concluded the unmodified message fix is better for discussion
lists. Email clients don't all treat munged messages the same way as
unmunged, and humans read these headers so it can confuse people,
causing messages not to be sent to the expected recipients. GNU Mailman
has an option to do "Munge From" always, but does not recommend using
it[1]. While we're not bound by what others do, it's worth noting that
other very large free software communities like Debian GNU/Linux have
adopted the unmodified message fix[2]. The unmodified messages fix
avoids breaking DKIM cryptographic signatures, which show the message
was authorized by the signing domain, which seems generally better for
security. Additionally, patchew has problems, as seen in the below
thread, subject was "[PATCH v6 0/4] 9p: Fix file ID collisions".

There is a small additional wrinkle. Very rarely, someone will send a
message to the list with a bad DKIM signature and publish a strict DMARC
policy, and in that case, we are forced to munge. I've searched all
messages posted to nongnu and gnu lists and, its always by someone
sending via their own mail server, or small enough to consider it that,
so its reasonable to ask them fix their DKIM signatures or turn off
their strict DMARC. I plan to setup an autoresponder to do that
automatically. Another case is if someone sends an html only email,
qemu-devel is configured to convert it to plaintext. That modifies the
message, and if its from a strict DMARC domain, the from munging is
done. Again, you can tell them to stop sending html only email.

I don't know who has the Qemu-devel list admin password, but whoever has
it can adopt the unmodified message fix by changing
dmarc_moderation_action to Accept here:
https://lists.nongnu.org/mailman/admin/qemu-devel/privacy/sender and
remove subject_prefix here
https://lists.nongnu.org/mailman/admin/qemu-devel/general

If the list admins went missing, email mailman@gnu.org and we can sort
out new ones eventually.

A few additional notes for completeness. We announced some of this at
https://lists.gnu.org/archive/html/savannah-hackers-public/2019-06/msg00018.html,
which includes information about other kinds of lists. For the unusual
cases of munging I described, we do from munging through exim because
mailman is not smart enough to only munge in these edge cases, and I'll
document that soon here[1].

[1]: https://wiki.list.org/DEV/DMARC
[2]: https://lists.debian.org/debian-devel-announce/2015/08/msg00003.html


Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> writes:

> On Montag, 2. September 2019 17:34:32 CEST Greg Kurz wrote:
>> On Sun, 01 Sep 2019 21:28:45 +0200
>> 
>> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
>> > On Donnerstag, 29. August 2019 19:02:34 CEST Greg Kurz wrote:
>> > > On Thu, 22 Aug 2019 15:18:54 -0700 (PDT)
>> > > 
>> > > no-reply@patchew.org wrote:
>> > > > Patchew URL:
>> > > > https://patchew.org/QEMU/cover.1566503584.git.qemu_oss@crudebyte.com/
>> > > > 
>> > > > 
>> > > > 
>> > > > Hi,
>> > > > 
>> > > > This series seems to have some coding style problems. See output below
>> > > > for
>> > 
>> > > > more information:
>> > [snip]
>> > 
>> > > > === OUTPUT BEGIN ===
>> > > > 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one
>> > > > export
>> > > > as an error) ERROR: Author email address is mangled by the mailing
>> > > > list
>> > > > #2:
>> > > > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
>> > > 
>> > > This is problematic since it ends up in the Author: field in git. Please
>> > > find a way to fix that.
>> > 
>> > Like in which way do you imagine that? And where is the actual practical
>> > problem? I mean every patch still has my signed-off-by tag with the
>> > correct
>> > email address ending up in git history.
>> 
>> Yes, this only breaks Author: if the patch is applied from the list.
>> 
>> > The cause for this issue is that the domain is configured to require DKIM
>> > signatures for all outgoing emails. That's why mailman replaces my address
>> > by "Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>"
>> > placeholder since it could not provide a valid signature.
>> > 
>> > There were good reasons for enabling DKIM and it is a good thing for all
>> > domains in general, since that ensures that (i.e. foreign) email addresses
>> > cannot be used as sender address if the actual sender is not authorized
>> > for
>> > sending emails with that address.
>> 
>> Don't know much about DKIM but google seems to confirm what you say.
>
> When you view the source of my emails you'll always see a "DKIM-Signature:" 
> field in the email header, which is a signature of the email's body and the 
> specific email header fields listed in the "DKIM-Signature:" block, so the 
> original server can choose by itself which header fields to include ("h=...") 
> for signing, but the standard requires the From: field must always be 
> included.
>
> A receiving server then obtains the public key from the domain's DNS records 
> and checks if the DKIM signature of the email was correct:
> https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail
>
> Additionally the receiving server obtains the so called "DMARC" entry from the 
> domain's DNS records. The "DMARC" DNS entry contains the domain's general 
> policies how receiving email servers shall handle verification of emails of 
> this domain. For instance the DMARC entry may list SMTP servers (e.g. IPs, DNS 
> names) eligble to send emails on behalf of the domain at all, and it defines 
> what receiving email servers shall do with emails which were identified of not 
> being from an eligible source (e.g. sender IP not listed in DMARC entry or 
> missing or wrong DKIM signature in email header). For instance if the policy 
> is "quarantine" in the DMARC entry then receiving servers are advised to 
> simply drop invalid emails:  https://en.wikipedia.org/wiki/DMARC
>
>> So, this means that patchew will complain each time you post if we can't
>> find a proper way to address that... :-\
>
> Well, mailman is handling this correctly. It replaces the "From:" field with a 
> placeholder and instead adds my actual email address as "Reply-To:" field. 
> That's the common way to handle this on mailing lists, as also mentioned here:
> https://en.wikipedia.org/wiki/DMARC#From:_rewriting
>
> So IMO patchew should automatically use the value of "Reply-To:" in that case 
> as author of patches instead.
>
> Reducing security cannot be the solution.
>
>> > What I changed in the meantime though is that you should get all my
>> > patches
>> > directly to your personal address, not only from the list. Or did you
>> > receive v6 again just from the list?
>> 
>> I've received the patches in my mailbox but I prefer to use the patchwork's
>> pwclient CLI to apply patches... and patchwork captures the patches from
>> the list, so I end up having to patch the authorship manually anyway.
>> 
>> How are you sending patches ? With git send-email ? If so, maybe you can
>> pass something like --from='"Christian Schoenebeck"
>> <qemu_oss@crudebyte.com>'. Since this is a different string, git will
>> assume you're sending someone else's patch : it will automatically add an
>> extra From: made out of the commit Author as recorded in the git tree.
>
> I use "git format-patch ..." to dump the invidiual emails as raw email sources 
> and then I'll send those raw emails from the command line. So I have even more 
> control of what is exactly sent out and could of course also add custom email 
> header fields if required, if that would solve the situation somehow, i.e. 
> manually as first test and later in automated way. That's not the issue here.
>
> The problem however is that there is probably not any header field I could add 
> that would solve the problem. Because I guess patchew is really just taking 
> the first "From:" field as author, period.
>
> I think the source files are available, so I could check that.
>

