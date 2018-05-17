Received: from eggs.gnu.org ([2001:4830:134:3::10]:49742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJHUM-0004tS-Ed
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJHUJ-0000mb-CG
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:54:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJHUJ-0000jw-1a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:54:27 -0400
References: <1526557877-293151-1-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c58c06b-4ee3-2f1e-1b32-2381ad7a6ce0@vivier.eu>
Date: Thu, 17 May 2018 13:54:10 +0200
MIME-Version: 1.0
In-Reply-To: <1526557877-293151-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: update comments to point to
 tcg_exec_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

Le 17/05/2018 à 13:51, Igor Mammedov a écrit :
> cpu_init() was replaced by cpu_create() since 2.12 but comments
> weren't updated. So update stale comments to point that page
> sizes arei actually initialized by tcg_exec_init(). Also move
> another qemu_host_page_size related comment before tcg_exec_init()
> where it belongs.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
