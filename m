Received: from eggs.gnu.org ([2001:4830:134:3::10]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cuvaN-0001Yl-8n
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cuvaI-000050-E7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cuvaI-0008VS-8m
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:35:26 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CA+KKJYDrS0c0GoxctMGG2cg+8C9Jqg_2LoiRVy59J8rnXiZYPA@mail.gmail.com>
	(Danil Antonov's message of "Sat, 1 Apr 2017 16:58:55 +0300")
References: <CA+KKJYDrS0c0GoxctMGG2cg+8C9Jqg_2LoiRVy59J8rnXiZYPA@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Apr 2017 08:35:03 +0200
Message-ID: <87k272knhk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 24/43] migration: made printf always
 compile in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org

Danil Antonov <g.danil.anto@gmail.com> wrote:
> From e5719e802fcd1d1b426d687524ed46f10d044941 Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 12:35:10 +0300
> Subject: [PATCH 24/43] migration: made printf always compile in debug output
>
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
>
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
