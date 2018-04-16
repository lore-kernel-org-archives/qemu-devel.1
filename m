Received: from eggs.gnu.org ([2001:4830:134:3::10]:50001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f88X4-00022C-DH
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f88X1-0005FP-1T
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:07:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f88X0-0005F1-Te
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:07:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-9-git-send-email-ian.jackson@eu.citrix.com>
	<874lkfxfxt.fsf@dusky.pond.sub.org>
	<23252.44539.262716.947319@mariner.uk.xensource.com>
	<87tvsbm8gl.fsf@dusky.pond.sub.org>
	<23252.54972.659826.276061@mariner.uk.xensource.com>
Date: Mon, 16 Apr 2018 20:06:59 +0200
In-Reply-To: <23252.54972.659826.276061@mariner.uk.xensource.com> (Ian
	Jackson's message of "Mon, 16 Apr 2018 18:00:44 +0100")
Message-ID: <87po2zkou4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Ian Jackson <ian.jackson@citrix.com> writes:

> Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas <uid>:<gid> facility"):
>> Ian Jackson <ian.jackson@citrix.com> writes:
>> > That would defer the getpwnam from argument parsing to os_setup_post.
>> > I think that's undesriable.
>> 
>> No argument.  But why can't os_parse_cmd_args() call getpwnam() as it
>> does now, then store user_pwd->pw_uid, ->pw_gid and ->pw_name instead of
>> user_pwd?  Store a null name when it parses the argument as UID:GID.
>
> Oh, I see.  It seems less obvious to me than what I have done, but I
> can do it like that if you like.

I just wanted to toss out the idea.  Please use your judgenment and do
it the way you like better.
