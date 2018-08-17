Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc5z-0005Qk-9F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc5u-0000Ot-Vx
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fqc5u-0000Od-RK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:35:02 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1534419358-10932-7-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 16 Aug 2018 13:35:56 +0200")
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
	<1534419358-10932-7-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 17 Aug 2018 12:34:52 +0200
Message-ID: <87mutluvqr.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/8] tests/device-introspection: Check
 that the qom-tree and qtree do not change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> Introspection should not change the qom-tree / qtree, so we should check
> this in the device-introspect-test, too. This patch helped to find lots
> of instrospection bugs during the QEMU v3.0 soft/hard-freeze period in the
> last two months.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
