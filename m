Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F8ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F96B2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F96B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVuk-000555-Oj
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iHVmB-0003CU-6V
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iHVm9-0006gt-Oa
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:22:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iHVm2-0006ba-0p; Mon, 07 Oct 2019 12:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 088BAC04BD33;
 Mon,  7 Oct 2019 16:22:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB7345D70E;
 Mon,  7 Oct 2019 16:21:44 +0000 (UTC)
Date: Mon, 7 Oct 2019 17:21:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 06/31] python: add commit-per-subsystem.py
Message-ID: <20191007162142.GO4656@redhat.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-7-vsementsov@virtuozzo.com>
 <20191007175514.19360a2b.cohuck@redhat.com>
 <cc355055-871d-9fb8-6f2d-f75d5cd40a3b@virtuozzo.com>
 <20191007181651.2fd72fbf.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007181651.2fd72fbf.cohuck@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 16:22:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "clg@kaod.org" <clg@kaod.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 06:16:51PM +0200, Cornelia Huck wrote:
> On Mon, 7 Oct 2019 16:10:02 +0000
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
> > 07.10.2019 18:55, Cornelia Huck wrote:
> > > On Tue,  1 Oct 2019 18:52:54 +0300
> > > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
> > >> +def git_add(pattern):
> > >> +    subprocess.run(['git', 'add', pattern])
> > >> +
> > >> +
> > >> +def git_commit(msg):
> > >> +    subprocess.run(['git', 'commit', '-m', msg], capture_output=True)
> > >> +
> > >> +
> > >> +maintainers = sys.argv[1]
> > >> +message = sys.argv[2].strip()
> > >> +
> > >> +subsystem = None
> > >> +
> > >> +shortnames = {
> > >> +    'Block layer core': 'block',
> > >> +    'ARM cores': 'arm',
> > >> +    'Network Block Device (NBD)': 'nbd',
> > >> +    'Command line option argument parsing': 'cmdline',
> > >> +    'Character device backends': 'chardev',
> > >> +    'S390 general architecture support': 's390'
> > >> +}
> > >> +
> > >> +
> > >> +def commit():
> > >> +    if subsystem:
> > >> +        msg = subsystem
> > >> +        if msg in shortnames:
> > >> +            msg = shortnames[msg]
> > >> +        msg += ': ' + message
> > >> +        git_commit(msg)
> > >> +
> > >> +
> > >> +with open(maintainers) as f:
> > >> +    for line in f:
> > >> +        line = line.rstrip()
> > >> +        if not line:
> > >> +            continue
> > >> +        if len(line) >= 2 and line[1] == ':':
> > >> +            if line[0] == 'F' and line[3:] not in ['*', '*/']:
> > >> +                git_add(line[3:])
> > >> +        else:
> > >> +            # new subsystem start
> > >> +            commit()
> > >> +
> > >> +            subsystem = line
> > >> +
> > >> +commit()  
> > > 
> > > Hm... I'm not sure about the purpose of this script (and my python is
> > > rather weak)... is this supposed to collect all changes covered by a
> > > subsystem F: pattern into one patch?  
> > 
> > Yes
> > 
> > > If so, what happens to files
> > > covered by multiple sections?
> > >   
> > 
> > Hmm, they just go to the first of these sections, mentioned in MAINTAINERS.
> > Is it bad I don't know, but I tried to automate it somehow. Anyway, I myself
> > can't have better idea about how to organize patches to the subsystems which
> > I don't know.
> > 
> 
> Yeah, that is a problem I don't have a solution for, either.
> 
> But the script should probably get at least a comment about its
> intended purpose and limitations? We don't really want people to start
> using it blindly.

Is this really a common enough problem to even justify having the
script to start with ?

It looks like its only really usable in the case where the changes
to each subsystem are totally self-contained, otherwise you'll get
git bisect failures. The user still has to go back and edit each
commit here to fill in a useful commit messages. It doesn't seem
to save much effort over 'git add -u sub/dir/ && git commit -s'
which is what I'd typically do for grouping changes that are
spread across the tree.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

