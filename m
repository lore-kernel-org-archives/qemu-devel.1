Received: from eggs.gnu.org ([2001:4830:134:3::10]:32902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk7nV-0000pI-V4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk7nS-0000kG-T2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk7nS-0000i7-M5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:56:38 -0400
Date: Tue, 22 Aug 2017 19:56:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822115632.GE3210@lemon>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-3-apahim@redhat.com>
	<20170822102456.GC3210@lemon>
	<CALAZnb2sgT+er96jA79nG7+bK3H2kN4MMjrPT+6wm9HF_ZT7pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAZnb2sgT+er96jA79nG7+bK3H2kN4MMjrPT+6wm9HF_ZT7pw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 02/11] qemu.py: avoid writing to
 stdout/stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, 08/22 13:11, Amador Pahim wrote:
> I don't think that the 'keep the behavior' principle should overcome
> what the messages actually are. The question is: are they warning
> messages? The way I see, the messages I changed in this commit to use
> the logging system are both debug messages.

I think the signal message is a warning.

Fam
