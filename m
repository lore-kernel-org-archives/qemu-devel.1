Received: from eggs.gnu.org ([2001:4830:134:3::10]:49506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9Vak-0003Cs-UM
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9Vah-0004Eg-Rm
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:56:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9Vah-0004CA-MA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:56:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-11-git-send-email-ian.jackson@eu.citrix.com>
Date: Fri, 20 Apr 2018 14:56:35 +0200
In-Reply-To: <1524156319-11465-11-git-send-email-ian.jackson@eu.citrix.com>
	(Ian Jackson's message of "Thu, 19 Apr 2018 17:45:13 +0100")
Message-ID: <87in8myr24.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/16] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Ian Jackson <ian.jackson@eu.citrix.com> writes:

> This allows the caller to specify a uid and gid to use, even if there
> is no corresponding password entry.  This will be useful in certain
> Xen configurations.
>
> We don't support just -runas <uid> because: (i) deprivileging without
> calling setgroups would be ineffective (ii) given only a uid we don't
> know what gid we ought to use (since uids may eppear in multiple
> passwd file entries with different gids).
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
