Received: from eggs.gnu.org ([2001:4830:134:3::10]:52502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVKuN-00058j-SU
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVKuN-0004l8-9b
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:54:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942834870.8972.2146924083027836035.stgit@frigg.lan>
	<87bmoq9g13.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c3e23be8-17f2-1fc8-5e4f-9aba38b1c1a7@twiddle.net>
Date: Wed, 12 Jul 2017 06:53:25 -1000
MIME-Version: 1.0
In-Reply-To: <87bmoq9g13.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 03/27] target: [tcg] Use a generic enum
 for DISAS_ values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 07/11/2017 11:10 PM, Alex Bennée wrote:
>> +typedef enum DisasJumpType {
>> +    DISAS_NEXT,
>> +    DISAS_TOO_MANY,
> 
> Is DISAS_TOO_MANY really a useful distinction. Sure we have ended the
> loop because of an instruction limit but the more important information
> is what it means for the epilogue code and how we go to the next block.

Yes. I think it is.

The reason is that it is the way that the generic loop can tell the target hook 
that it terminated the instruction fetch loop.  There may (or may not) be 
something special that the target needs to do for that specific case.


r~
