Received: from eggs.gnu.org ([2001:4830:134:3::10]:35598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cxTpW-00066I-Cl
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cxTpT-0001mi-Ae
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:33:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:57658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1cxTpS-0001mM-V6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:33:39 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <094e28c1-b780-f8ff-fc6a-9f6dd3421a3a@intel.com>
Date: Mon, 10 Apr 2017 10:34:52 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com



On 07.04.2017 18:11, Marc-André Lureau wrote:
> Hi
>
> On Fri, Apr 7, 2017 at 4:41 PM Daniel P. Berrange
>
>     > +        .name = "data-path",
>     > +        .type = QEMU_OPT_STRING,
>     > +        .help = "Socket path to use for data exhange",
>     > +    },
>     > +    {
>     > +        .name = "ctrl-path",
>     > +        .type = QEMU_OPT_STRING,
>     > +        .help = "Socket path to use for out-of-band control
>     messages",
>     > +    },
>
>     I'm still not convinced by the need for 2 separate UNIX sockets,
>     unless
>     there's a performance reason, but that looks unlikely.
>
>
> We would also need something more than an implementation of the 
> protocol that qemu is going to rely on as an external dependency.  A 
> protocol specification would help to start the discussion.
I would agree with you, Can we adopt the current swtpm's control 
interface as initial proposal.
> Alternatively, I would suggest to not rely on a public protocol,
What do you mean by public protocol here, can you please help me 
understanding this.

- Amarnath
