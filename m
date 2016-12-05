Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDxqo-0007CA-GI
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDxql-0000YN-9f
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:18:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cDxql-0000Y5-39
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:18:51 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19A5C8B137
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 18:18:50 +0000 (UTC)
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-16-git-send-email-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
Date: Mon, 5 Dec 2016 19:18:47 +0100
MIME-Version: 1.0
In-Reply-To: <1480713496-11213-16-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/17] target-i386: Define static
 "base" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Am 02.12.2016 um 22:18 schrieb Eduardo Habkost:
> The query-cpu-model-expand QMP command needs at least one static
> model, to allow the "static" expansion mode to be implemented.
> Instead of defining static versions of every CPU model, define a
> "base" CPU model that has absolutely no feature flag enabled.
>

Introducing separate ones makes feature lists presented to the user much 
shorter (and therefore easier to maintain). But I don't know how libvirt 
wants to deal with models on x86 in the future.

How long is the static expansion on a recent intel CPU?


-- 

David
