Received: from eggs.gnu.org ([209.51.188.92]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDQ87-0005j1-Ox
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDQ86-0002TE-Vd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDQ86-0002Sp-Ny
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
	<20190405064121.23662-2-richardw.yang@linux.intel.com>
Date: Mon, 08 Apr 2019 10:59:48 +0200
In-Reply-To: <20190405064121.23662-2-richardw.yang@linux.intel.com> (Wei
	Yang's message of "Fri, 5 Apr 2019 14:41:18 +0800")
Message-ID: <875zroub23.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/4] vl.c: make find_default_machine()
 local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

Wei Yang <richardw.yang@linux.intel.com> writes:

> Function find_default_machine() is introduced by commit 2c8cffa599b7
> "vl: make find_default_machine externally visible", and it was used
> outside of vl.c until commit a904410af5f1 "pc_sysfw: remove the rom_only
> property".
>
> Commit a904410af5f1 "pc_sysfw: remove the rom_only property" removed the
> only user of find_default_machine() outside vl.c, but neglected to make
> it static. Do that now.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
