Received: from eggs.gnu.org ([2001:4830:134:3::10]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daViu-0006Wp-Tl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daVit-0002tS-RW
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:28:12 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-5-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <25f12e18-b096-99b9-e235-1f8f93466107@redhat.com>
Date: Wed, 26 Jul 2017 19:28:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170725211523.3998-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/12] tests: Pass literal format
 strings directly to qmp_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, armbru@redhat.com, stefanha@redhat.com



On 07/25/2017 05:15 PM, Eric Blake wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> The qmp_FOO() take a printf-like format string.  In a few places, we
> assign a string literal to a variable and pass that instead of simply
> passing the literal.  Clean that up.
> 
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <1500645206-13559-4-git-send-email-armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
