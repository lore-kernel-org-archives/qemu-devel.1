Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dk8S3-0005Dt-Oz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dk8S0-0005AI-Gw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:38:35 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dk8S0-0005A8-Bs
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:38:32 -0400
Received: by mail-it0-f43.google.com with SMTP id x187so23435367ite.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 05:38:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822115632.GE3210@lemon>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-3-apahim@redhat.com>
	<20170822102456.GC3210@lemon>
	<CALAZnb2sgT+er96jA79nG7+bK3H2kN4MMjrPT+6wm9HF_ZT7pw@mail.gmail.com>
	<20170822115632.GE3210@lemon>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 22 Aug 2017 14:38:30 +0200
Message-ID: <CALAZnb2wp1UgDvO2fFiXQM0_y-4JPTRoxr-osX5NM1Cd=TFBcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Aug 22, 2017 at 1:56 PM, Fam Zheng <famz@redhat.com> wrote:
> On Tue, 08/22 13:11, Amador Pahim wrote:
>> I don't think that the 'keep the behavior' principle should overcome
>> what the messages actually are. The question is: are they warning
>> messages? The way I see, the messages I changed in this commit to use
>> the logging system are both debug messages.
>
> I think the signal message is a warning.

Ok, that's a good reason to change. I will change that one in the next version.
Thanks.

>
> Fam
