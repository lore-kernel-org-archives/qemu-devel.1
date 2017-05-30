Received: from eggs.gnu.org ([2001:4830:134:3::10]:53543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFeEg-0007Ui-N8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFeEd-0003dl-Jq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFeEd-0003db-Dn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66A865D689
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:18:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-10-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:25 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-10-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 12:18:36 +0200
Message-ID: <87y3tefy0z.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/12] hmp: add announce paraters info/set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

Vladislav Yasevich <vyasevic@redhat.com> wrote:
> Add HMP command to control and read annoucment parameters.
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> + cleanup:
> +    if (err) {
> +        error_report_err(err);
> +    }
> +}


My understanding is that this the "cool way" to spell this nowadays is:

hmp_handle_error(mon, &err);

Just in case you want to change it.
