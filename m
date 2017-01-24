Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxQU-0006IX-97
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxQT-0006T1-Ji
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:30:06 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1479837270-79005-11-git-send-email-vsementsov@virtuozzo.com>
	(Vladimir Sementsov-Ogievskiy's message of "Tue, 22 Nov 2016 20:54:23
	+0300")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-11-git-send-email-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:29:55 +0100
Message-ID: <87efzsajqk.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/17] migration/qemu-file: add
 qemu_put_counted_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> Add function opposite to qemu_get_counted_string.
> qemu_put_counted_string puts one-byte length of the string (string
> should not be longer than 255 characters), and then it puts the string,
> without last zero byte.
>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
