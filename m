Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A27C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFA522CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFA522CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QRG-0007pT-AO
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i5QQU-0007CJ-NA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i5QQS-0005C3-Oy
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i5QQS-0005BZ-GN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D681300C72A;
 Wed,  4 Sep 2019 08:13:59 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B4775DA60;
 Wed,  4 Sep 2019 08:13:57 +0000 (UTC)
Date: Wed, 4 Sep 2019 09:13:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ian Kelling <iank@fsf.org>
Message-ID: <20190904081354.GA19582@redhat.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver> <87r24xqjoz.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r24xqjoz.fsf@fsf.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 04 Sep 2019 08:13:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: stefanha@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, antonios.motakis@huawei.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 03:11:08PM -0400, Ian Kelling wrote:
> At FSF, we've been working on this issue recently. I was planning to
> send a general message to qemu-devel, but someone brought it up in a
> thread below, so I'm doing it now.
> 
> Currently, a message sent to qemu-devel from a domain that publishes a
> strict DMARC policy gets what mailman calls "Munge From". For example,
> for a message sent to the list:
> 
> From: Anne Example Person <exampleperson@examplepersonsdomain>
> 
> Is modified my Mailman and sent to subscribers as:
> 
> From: Anne Example Person via Qemu-devel <qemu-devel@nongnu.org>
> Reply-To: Anne Example Person <exampleperson@examplepersonsdomain>
> 
> We've recently made possible an alternative solution that does not need
> munging and I call the unmodified message fix. Currently, mailman adds
> "[Qemu-devel] " to the subject of messages. Modifying the message breaks
> DKIM message signature and thus DMARC. In short: turn that off, and we
> can stop from munging. Many lists are already this way, including most
> popular @gnu and @nongnu lists, and this week we are doing a mass
> conversion of lists which never touched DMARC related list settings (not
> qemu-devel). Instead of using the subject prefix to identify a list,
> subscribers can use the List-Id, To, and Cc headers.  List information
> can also be be put in the welcome email to subscribers and the list
> information page by list administrators.
> 
> Without going into all of the details, here's a few points about why we
> concluded the unmodified message fix is better for discussion
> lists. Email clients don't all treat munged messages the same way as
> unmunged, and humans read these headers so it can confuse people,
> causing messages not to be sent to the expected recipients. GNU Mailman
> has an option to do "Munge From" always, but does not recommend using
> it[1]. While we're not bound by what others do, it's worth noting that
> other very large free software communities like Debian GNU/Linux have
> adopted the unmodified message fix[2]. The unmodified messages fix
> avoids breaking DKIM cryptographic signatures, which show the message
> was authorized by the signing domain, which seems generally better for
> security. Additionally, patchew has problems, as seen in the below
> thread, subject was "[PATCH v6 0/4] 9p: Fix file ID collisions".
> 
> There is a small additional wrinkle. Very rarely, someone will send a
> message to the list with a bad DKIM signature and publish a strict DMARC
> policy, and in that case, we are forced to munge. I've searched all
> messages posted to nongnu and gnu lists and, its always by someone
> sending via their own mail server, or small enough to consider it that,
> so its reasonable to ask them fix their DKIM signatures or turn off
> their strict DMARC. I plan to setup an autoresponder to do that
> automatically. Another case is if someone sends an html only email,
> qemu-devel is configured to convert it to plaintext. That modifies the
> message, and if its from a strict DMARC domain, the from munging is
> done. Again, you can tell them to stop sending html only email.

I think we should change mailman settings to *NOT* convert HTML to
plain text. It is pretty easy to setup mail clients to do this
conversion when viewing instead, which will avoid the DMARC problems.

eg with mutt you can add

  auto_view text/html
  alternative_order text/plain text/html

and in $HOME/.mailcap something like

  text/html; elinks -dump -localhost 1 -no-connect 1 -default-mime-type text/html %s; needsterminal; copiousoutput;



> 
> I don't know who has the Qemu-devel list admin password, but whoever has
> it can adopt the unmodified message fix by changing
> dmarc_moderation_action to Accept here:
> https://lists.nongnu.org/mailman/admin/qemu-devel/privacy/sender and
> remove subject_prefix here
> https://lists.nongnu.org/mailman/admin/qemu-devel/general
> 
> If the list admins went missing, email mailman@gnu.org and we can sort
> out new ones eventually.
> 
> A few additional notes for completeness. We announced some of this at
> https://lists.gnu.org/archive/html/savannah-hackers-public/2019-06/msg00018.html,
> which includes information about other kinds of lists. For the unusual
> cases of munging I described, we do from munging through exim because
> mailman is not smart enough to only munge in these edge cases, and I'll
> document that soon here[1].
> 
> [1]: https://wiki.list.org/DEV/DMARC
> [2]: https://lists.debian.org/debian-devel-announce/2015/08/msg00003.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

