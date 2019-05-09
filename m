Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20026C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D6721479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj4Z-0004JS-QO
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:26:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOj1d-0002FE-5T
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOj1b-00029v-Oh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOj1Z-00028j-11
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44D8230B4A6A;
	Thu,  9 May 2019 13:23:48 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3AD419744;
	Thu,  9 May 2019 13:23:36 +0000 (UTC)
Date: Thu, 9 May 2019 14:23:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190509132333.GX31299@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-13-kraxel@redhat.com>
	<12c8586d-5f43-f35c-0c43-939e535f93e9@redhat.com>
	<20190509131003.vowa3f7ikm5lurci@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509131003.vowa3f7ikm5lurci@sirius.home.kraxel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 09 May 2019 13:23:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/13] tests/vm: fedora autoinstall,
 using serial console
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
	=?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
	David Hildenbrand <david@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 03:10:03PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +        # shutdown
> > > +        self.ssh_root("poweroff")
> > > +        self.console_wait("sleep state S5")
> > > +        self.wait()
> > > +
> > > +        if os.path.exists(img):
> > > +            os.remove(img)
> > > +        os.rename(img_tmp, img)
> > > +        os.remove(iso)
> > > +        self.print_step("All done")
> > > +
> > > +if __name__ == "__main__":
> > > +    sys.exit(basevm.main(FedoraVM))
> 
> > Maybe you could also do a kickstart installation instead?
> 
> Well, the tricky part is how to get the kickstart/autoinstall/whatever
> file passed to the guest then, in a way that works for every guest ...

Libosinfo reports use of cdrom, disk, floppy or initrd injection for
providing the installer automation file. Distros support one of more
of these methods, but there's no single one that works everywhere
afaik.

FWIW, virt-install recently got ability to auto-install images using
the libosinfo installer files. We don't have coverage for any BSD's
though in libosinfo at this time though.

Regards,
Daniel

[1] https://gitlab.com/libosinfo/osinfo-db/tree/master/data/install-script
    The <injection-method> element in the XML files
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

