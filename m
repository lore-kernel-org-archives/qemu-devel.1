Received: from eggs.gnu.org ([2001:4830:134:3::10]:43582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqDQo-0005xv-0e
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqDQk-00029V-3j
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cqDQj-000295-To
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD3878123E
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 06:38:05 +0000 (UTC)
Message-ID: <1490078281.7490.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Mar 2017 07:38:01 +0100
In-Reply-To: <20170320173840.3626-3-dgilbert@redhat.com>
References: <20170320173840.3626-1-dgilbert@redhat.com>
	<20170320173840.3626-3-dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] wavcapture: Convert to error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, quintela@redhat.com

On Mo, 2017-03-20 at 17:38 +0000, Dr. David Alan Gilbert (git) wrote:
> Kill off a pile of monitor_printf's and cur_mon usage.
> The only one left in wavcapture.c is the info case.

Reviewed-by: Gerd Hoffmann <kraxel@gmail.com>
