Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVEPv-0001ay-Ud
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVEPs-0002zB-HR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:03:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVEPs-0002ye-Bb
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:03:16 -0400
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d50a447-ac11-f7e1-33e1-a3ffcad5b455@redhat.com>
Date: Tue, 19 Jun 2018 06:03:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180618175958.29073-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] Revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: tamiko@43-1.org, arfrever.fta@gmail.com

On 06/18/2018 12:59 PM, Markus Armbruster wrote:
> From: Matthias Maier <tamiko@43-1.org>
> 
> This commit removes the PYTHON_UTF8 workaround. The problem with setting
> 
>    LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8
> 
> is that the en_US.UTF-8 locale might not be available. In this case
> setting above locales results in build errors even though another UTF-8
> locale was originally set [1]. The only stable way of fixing the
> encoding problem is by explicitly annotating encoding/decoding in the
> python script.
> 
> [1] https://bugs.gentoo.org/657766
> 
> Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Signed-off-by: Matthias Maier <tamiko@43-1.org>
> Message-Id: <20180615220205.6929-3-tamiko@43-1.org>
> ---

Markus, does this need S-o-b from you?  (Then again, if it goes in 
through your tree, that's a moot point, as you'd add it as maintainer)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
