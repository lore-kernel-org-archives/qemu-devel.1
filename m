Received: from eggs.gnu.org ([2001:4830:134:3::10]:35550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e05YU-0007Wi-JR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e05YP-0003Va-Nb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:47:10 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e05YP-0003Ua-Gv
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:47:05 -0400
Received: by mail-wr0-f179.google.com with SMTP id l24so7853722wre.1
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:47:05 -0700 (PDT)
References: <20171005105157.10831-1-dgilbert@redhat.com>
	<20171005105157.10831-4-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19c477ab-a3dc-a994-905b-7a8d01298a76@redhat.com>
Date: Thu, 5 Oct 2017 14:47:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171005105157.10831-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 3/5] hmp-commands-info: Fix "info
 rocker-FOO" misspellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 05/10/2017 12:51, Dr. David Alan Gilbert (git) wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> Screwed up in commit da76ee7.

Let me introduce you to these two aliases:

        whatis = "show -s --pretty='tformat:%h (\"%s\", %cd)' --date=short"
        pwhatis = "show -s --pretty='tformat:%h, \"%s\", %cd' --date=short"

$ git whatis da76ee7
da76ee76f7 ("hmp-commands-info: move info_cmds content out of monitor.c", 2015-09-16)

pwhatis is more appropriate if you are including the commit at the end
of a parenthetical remark, like

   ... (see commit message for 53ec73e, "block: Use bdrv_drain to
   replace uncessary bdrv_drain_all", 2015-07-07).

Paolo

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20171002134538.23332-2-armbru@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
