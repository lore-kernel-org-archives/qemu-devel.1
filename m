Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egmX2-00033s-5R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egmWx-00049c-EJ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1egmWx-00049H-6I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:10:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E6512D1CD
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:10:02 +0000 (UTC)
Received: from [10.36.116.147] (ovpn-116-147.ams2.redhat.com [10.36.116.147])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF71860BE3
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:10:01 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0395258-20bd-657a-fc79-c1e4bafe15cb@redhat.com>
Date: Wed, 31 Jan 2018 08:10:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/18] Clean up includes to reduce compile
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 30.01.2018 11:21, Markus Armbruster wrote:
> We have awfully many "touch it, recompile the world" headers.  Right
> now, I count about fifty that are prerequisites of more than half the
> objects in my "build everything" tree.

Could you maybe share the list of these 50 headers? ... cleaning this up
could also be a good task for https://wiki.qemu.org/BiteSizedTasks I guess?

 Thomas
