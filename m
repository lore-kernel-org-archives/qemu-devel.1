Received: from eggs.gnu.org ([2001:4830:134:3::10]:57869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsJ2-0002KR-Dh
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsIw-0003eW-DT
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHsIw-0003dY-7M
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:44:22 -0400
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
	<20170605133650.GM4294@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ece5004d-f732-5110-79c2-2917e20d048a@redhat.com>
Date: Mon, 5 Jun 2017 15:44:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170605133650.GM4294@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 05/06/2017 15:36, Eduardo Habkost wrote:
> On Mon, Jun 05, 2017 at 02:10:06PM +0100, Peter Maydell wrote:
>> Why do we have both of these APIs?
> 
> I don't know.  Probably because the QOM property API was
> introduced, it was just a subset of of the features provided by
> qdev properties, so the qdev API had to be kept.

Indeed---especially there were no QOM class properties (and there are
still no default values, which is the other place where we walk the
props array).

Paolo
