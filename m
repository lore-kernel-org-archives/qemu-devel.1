Received: from eggs.gnu.org ([2001:4830:134:3::10]:46274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anichang@protonmail.ch>) id 1dKv6E-0002km-Bs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anichang@protonmail.ch>) id 1dKv6B-0005AF-5p
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:19:50 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:38832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anichang@protonmail.ch>)
	id 1dKv6A-00059y-N9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:19:47 -0400
Date: Tue, 13 Jun 2017 19:19:38 -0400
From: Anichang <anichang@protonmail.ch>
Reply-To: Anichang <anichang@protonmail.ch>
Message-ID: <SeRHJ5levK9xMyMFEYUU0yz5EJXCFnKEV6bCxqprhOF_XptOZig7uidIjCnYHpeZx0ac891mMjZK7_IepIFj5OUQ7k_wFK0GEHyHD-22LOA=@protonmail.ch>
In-Reply-To: <a0116cc5-42e3-b784-e6b2-bbe8a63c5225@redhat.com>
References: <20170608193822.24418-1-rolnik@amazon.com>
	<20170608193822.24418-2-rolnik@amazon.com>
	<a0116cc5-42e3-b784-e6b2-bbe8a63c5225@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH RFC v19 11/13] target-avr: Put all
 translation code into one compilation unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>

LS0tLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLS0tLQpTdWJqZWN0OiBSZTogW1FlbXUtZGV2
ZWxdIFtQQVRDSCBSRkMgdjE5IDExLzEzXSB0YXJnZXQtYXZyOiBQdXQgYWxsIHRyYW5zbGF0aW9u
IGNvZGUgaW50byBvbmUgY29tcGlsYXRpb24gdW5pdApMb2NhbCBUaW1lOiBKdW5lIDEzLCAyMDE3
IDEwOjA3IFBNClVUQyBUaW1lOiBKdW5lIDEzLCAyMDE3IDg6MDcgUE0KRnJvbTogdGh1dGhAcmVk
aGF0LmNvbQpUbzogTWljaGFlbCBSb2xuaWsgPG1yb2xuaWtAZ21haWwuY29tPiwgcWVtdS1kZXZl
bEBub25nbnUub3JnClJpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+LCBhbmljaGFu
Z0Bwcm90b25tYWlsLmNoCgpPbiAwOC4wNi4yMDE3IDIxOjM4LCBNaWNoYWVsIFJvbG5payB3cm90
ZToKJmd0OyBGcm9tOiBNaWNoYWVsIFJvbG5pawomZ3Q7CiZndDsgRnJvbTogUmljaGFyZCBIZW5k
ZXJzb24KCkZyb20gd2hvbSBpcyB0aGlzIHBhdGNoPyAuLi4gbG9va3MgbGlrZSB0aGVyZSBpcyBz
b21ldGhpbmcgd3Jvbmcgd2l0aAp0aGUgd2F5IHlvdSBzZW5kIHRoZSBwYXRjaGVzLi4uCgpJdCBt
YXkgaGF2ZSBiZWVuIG15IGZhdWx0LiBBIGJpdCBvZiBoaXN0b3J5OgotIExhc3QgeWVhciBNaWNo
YWVsIFJvbG5payBwcm9kdWNlZCBhIHRhcmdldC1hdnIgcGF0Y2hzZXQuCi0gQSBmZXcgZGF5cyBs
YXRlciBSaWNoYXJkIEhlbmRlcnNvbiBjbGVhbmVkIHVwIGFuZCByZS1zdHlsZWQuCi0gTGFzdCB3
ZWVrIEkgaGF2ZSBmb3VuZCBSaWNoYXJkJ3MgcmVwbywgZWRpdGVkIHRvIGNvcGUgd2l0aCB0aGUg
bmV3IHRhcmdldC9hcmNoIGRpcmVjdG9yeSBzdHJ1Y3R1cmUsIG1lcmdlZCBpbnRvIG15IGxvY2Fs
IGNvcHkgb2YgSEVBRCwgYW5kIGJ1aWx0LiBUaGVuIHNpZ25hbGVkIHRvIHRoZSBsaXN0LCBhbmQg
YXNrZWQgTWljaGFlbCB0byBmaXggdGhlIGJ1Z3MuIFNvIGhlIG9wZW5lZCBhIG5ldyByZXBvIG9u
IGdpdGh1YiwgSSBoYXZlIHNlbnQgYSBwdWxsIHJlcXVlc3QgYW5kIGhlIG1lcmdlZCBteSByZXBv
LgoKSW4gdGhlIHdoaWxlIFBldGVyIE1heWRlbCBsYXN0IHdlZWsgd3JvdGUgKGFib3V0IG15IHBh
dGNoZXMpOgoKIllvdXIgcGF0Y2ggYXR0YWNoZWQgdG8gdGhpcyBtYWlsIGFwcGVhcnMgdG8gYmUg
YSBtZXJnZSBjb21taXQKb2Ygc29tZSBraW5kLiBZb3UgZG9uJ3Qgd2FudCB0aGF0IC0tIHlvdSBu
ZWVkIHRvIHJlYmFzZSB0aGUKQVZSIHBhdGNoZXMgb24gY3VycmVudCBtYXN0ZXIsIHJhdGhlciB0
aGFuIG1lcmdpbmcgYW55dGhpbmcuIgoKVGhpcyBtaXN0YWtlIG1heSBoYXZlIGJlZW4gcHJvcGFn
YXRlZC4gQnV0IEkgZGlkbid0IGhhbmRsZSB0aGlzIGJpdCB0byBNaWNoYWVsLCBhbmQgaGUgbWln
aHQgaGF2ZSBsb3N0IHRoZXNlIG1haWxzLgoKUmVnYXJkcw==
