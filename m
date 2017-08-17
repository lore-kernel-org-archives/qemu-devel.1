Received: from eggs.gnu.org ([2001:4830:134:3::10]:33780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diDI2-0000r7-2Y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diDHy-00053r-P1
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:24:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diDHy-00053W-Ez
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:24:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
	<20170815085732.9794-2-ldoktor@redhat.com>
	<87fuctm2ql.fsf@dusky.pond.sub.org>
	<343636b3-85d2-cb2b-8975-dcc1bb0ddee1@redhat.com>
	<87pobvxxdb.fsf@dusky.pond.sub.org>
	<6363601c-231e-7910-3e76-9497a4645e81@redhat.com>
Date: Thu, 17 Aug 2017 07:24:05 +0200
In-Reply-To: <6363601c-231e-7910-3e76-9497a4645e81@redhat.com>
	(=?utf-8?B?Ikx1a8OhxaE=?=
	Doktor"'s message of "Wed, 16 Aug 2017 19:48:24 +0200")
Message-ID: <87efsasr62.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:

> Dne 16.8.2017 v 18:58 Markus Armbruster napsal(a):
>> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>>=20
>>> Dne 15.8.2017 v 14:31 Markus Armbruster napsal(a):
>>>> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>>>>
>>>>> No actual code changes, just several pylint/style fixes and docstring
>>>>> clarifications.
>>>>>
>>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>>> ---
>>>>>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++-------=
----------
>>>>>  1 file changed, 53 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>> index 880e3e8..466aaab 100644
>>>>> --- a/scripts/qemu.py
>>>>> +++ b/scripts/qemu.py
>>>>> @@ -23,8 +23,22 @@ import qmp.qmp
>>>>>  class QEMUMachine(object):
>>>>>      '''A QEMU VM'''
>>>>>=20=20
>>>>> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,=
 test_dir=3D"/var/tmp",
>>>>> -                 monitor_address=3DNone, socket_scm_helper=3DNone, d=
ebug=3DFalse):
>>>>> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
>>>>> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
>>>>> +                 socket_scm_helper=3DNone, debug=3DFalse):
>>>>> +        '''
>>>>> +        Create a QEMUMachine object
>>>>
>>>> Initialize a QEMUMachine
>>>>
>>>> Rationale: it's __init__, not __create__, and "object" is redundant.
>>>>
>>>
>>> sure
>>>
>>>>> +
>>>>> +        @param binary: path to the qemu binary (str)
>>>>
>>>> Drop (str), because what else could it be?
>>>
>>> it could be shlex.split of arguments to be passed to process. Anyway no=
 strong opinion here so I dropping it...
>>>
>>>>
>>>>> +        @param args: initial list of extra arguments
>>>>
>>>> If this is the initial list, then what's the final list?
>>>>
>>>
>>> It's the basic set of arguments which can be modified before the execut=
ion. Do you think it requires additional explanation, or would you like to =
improve it somehow?
>>=20
>> Can this list of extra arguments really be *modified*?  Adding more
>> arguments doesn't count for me --- I'd consider them added to the
>> "non-extra" arguments.
>>=20
>
> Yes, one can remove, shuffle or modify it.

Bizarre :)

Who's "one"?

>> Drop "initial"?
>
> I can do that but it can give false impression that the args will be pres=
ent. Anyway it's probably just a corner case so I'll drop it.

If it's intended to be modified, then keeping "initial" might be best.
Your choice.

>>=20
>>>>> +        @param wrapper: list of arguments used as prefix to qemu bin=
ary
>>>>> +        @param name: name of this object (used for log/monitor/... f=
ile names)
>>>> prefix for socket and log file names (default: qemu-PID)
>>>>
>>>
>>> Sure, both make sense to me.
>>>
>>>>> +        @param test_dir: base location to put log/monitor/... files =
in
>>>>
>>>> where to create socket and log file
>>>>
>>>> Aside: test_dir is a lousy name.
>>>
>>> Agree but changing names is tricky as people might be using kwargs to s=
et it. Anyway using your description here, keeping the possible rename for =
a separate patchset (if needed).
>>=20
>> I'm merely observing the lousiness of this name.  I'm not asking you to
>> do anything about it :)
>>=20
>>>>> +        @param monitor_address: custom address for QMP monitor
>>>>
>>>> Yes, but what *is* a custom address?  Its user _base_args() appears to
>>>> expect either a pair of strings (host, port) or a string filename.
>>>>
>>>
>>> If you insist I can add something like "a tuple(host, port) or string t=
o specify path", but I find it unnecessary detailed...
>>=20
>> I'm not the maintainer, I'm definitely not insisting on anything.
>>=20
>> If you're aiming for brevity, then drop "custom".
>>=20
>
> OK, removing in v6
>
>>>>> +        @param socket_scm_helper: path to scm_helper binary (to forw=
ard fds)
>>>>
>>>> What is an scm_helper, and why would I want to use it?
>>>>
>>>
>>> To forward a file descriptor. It's for example used in tests/qemu-iotes=
ts/045 or tests/qemu-iotests/147
>>=20
>> What about "socket_scm_helper: helper program, required for send_fd_scm(=
)"?
>>=20
>>>>> +        @param debug: enable debug mode (forwarded to QMP helper and=
 such)
>>>>
>>>> What is a QMP helper?  To what else is debug forwarded?
>>>>
>>>
>>> Debug is set in `self._debug` and can be consumed by anyone who has acc=
ess to this variable. Currently that is the QMP, but people can inherit and=
 use that variable to adjust their behavior.
>>=20
>> Drop the parenthesis?
>>=20
>
> OK
>
>>>>> +        @note: Qemu process is not started until launch() is used.
>>>>
>>>> until launch().
>>>>
>>>
>>> OK
>>=20
>> One more thing: what the use of "@param"?
>>=20
>
> The API documentation can be autogenerated by doxygen, it uses those keyw=
ords to make it easier to read (and to create links, warnings, ...)

"Can" or "could"?  As far as I can tell, we aren't actually using
doxygen for anything, are we?  Just like we aren't actually using
GTK-Doc.  Yet its comment rash^H^H^H^Hannotations can be found here and
there, commonly mixed up with unannotated code, and often syntactically
invalid.  No surprise, since they've never been processed by their
intended consumer.

If we decide we want to generate documentation, we should pick *one*
system and stick to it.  Having every deveoper sprinkle "his" code with
the annotations he's used to from elsewhere will do us no good.

>>>>> +        '''
>>>>
>>>> It's an improvement.
>>>>
>>>>>          if name is None:
>>>>>              name =3D "qemu-%d" % os.getpid()
>>>>>          if monitor_address is None:
>>>>> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>>>>>          self._qemu_log_path =3D os.path.join(test_dir, name + ".log")
>>>>>          self._popen =3D None
>>>>>          self._binary =3D binary
>>>>> -        self._args =3D list(args) # Force copy args in case we modif=
y them
>>>>> +        self._args =3D list(args)     # Force copy args in case we m=
odify them
>>>>>          self._wrapper =3D wrapper
>>>>>          self._events =3D []
>>>>>          self._iolog =3D None
>>>>>          self._socket_scm_helper =3D socket_scm_helper
>>>>>          self._debug =3D debug
>>>>> +        self._qmp =3D None
>>>>>=20=20
>>>>>      # This can be used to add an unused monitor instance.
>>>>>      def add_monitor_telnet(self, ip, port):
>>>>> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>>>>>          if self._socket_scm_helper is None:
>>>>>              print >>sys.stderr, "No path to socket_scm_helper set"
>>>>>              return -1
>>>>> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
>>>>> +        if not os.path.exists(self._socket_scm_helper):
>>>>>              print >>sys.stderr, "%s does not exist" % self._socket_s=
cm_helper
>>>>>              return -1
>>>>>          fd_param =3D ["%s" % self._socket_scm_helper,
>>>>>                      "%d" % self._qmp.get_sock_fd(),
>>>>>                      "%s" % fd_file_path]
>>>>>          devnull =3D open('/dev/null', 'rb')
>>>>> -        p =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Ds=
ys.stdout,
>>>>> -                             stderr=3Dsys.stderr)
>>>>> -        return p.wait()
>>>>> +        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=
=3Dsys.stdout,
>>>>> +                                stderr=3Dsys.stderr)
>>>>> +        return proc.wait()
>>>>>=20=20
>>>>>      @staticmethod
>>>>>      def _remove_if_exists(path):
>>>>> @@ -99,8 +114,8 @@ class QEMUMachine(object):
>>>>>          return self._popen.pid
>>>>>=20=20
>>>>>      def _load_io_log(self):
>>>>> -        with open(self._qemu_log_path, "r") as fh:
>>>>> -            self._iolog =3D fh.read()
>>>>> +        with open(self._qemu_log_path, "r") as iolog:
>>>>> +            self._iolog =3D iolog.read()
>>>>>=20=20
>>>>>      def _base_args(self):
>>>>>          if isinstance(self._monitor_address, tuple):
>>>>> @@ -114,8 +129,8 @@ class QEMUMachine(object):
>>>>>                  '-display', 'none', '-vga', 'none']
>>>>>=20=20
>>>>>      def _pre_launch(self):
>>>>> -        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addr=
ess, server=3DTrue,
>>>>> -                                                debug=3Dself._debug)
>>>>> +        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addr=
ess,
>>>>> +                                                server=3DTrue, debug=
=3Dself._debug)
>>>>
>>>> Recommend to break the line between the last two arguments.
>>>>
>>>
>>> I'm not used to do that, but I can most certainly do that. Do you want =
me to change all places (eg. in the next chunk)
>>=20
>> PEP8 asks you to limit all lines to a maximum of 79 characters.  This
>> one is right at the maximum.  Tolerable, but I prefer my lines a bit
>> shorter.  Use your judgement.
>>=20
>
> OK, I though you want to enforce the one-arg-per-line limit. I usually go=
 with <=3D79 (+ '\n') so this is fine by me, but I'll put it into next line=
 if that makes you happier.

Please wrap your lines in e-mail, too :)

>>>>>=20=20
>>>>>      def _post_launch(self):
>>>>>          self._qmp.accept()
>>>>> @@ -131,9 +146,11 @@ class QEMUMachine(object):
>>>>>          qemulog =3D open(self._qemu_log_path, 'wb')
>>>>>          try:
>>>>>              self._pre_launch()
>>>>> -            args =3D self._wrapper + [self._binary] + self._base_arg=
s() + self._args
>>>>> +            args =3D (self._wrapper + [self._binary] + self._base_ar=
gs() +
>>>>> +                    self._args)
>>>>>              self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, =
stdout=3Dqemulog,
>>>>> -                                           stderr=3Dsubprocess.STDOU=
T, shell=3DFalse)
>>>>> +                                           stderr=3Dsubprocess.STDOU=
T,
>>>>> +                                           shell=3DFalse)
>>>>>              self._post_launch()
>>>>>          except:
>>>>>              if self.is_running():
>>>>> @@ -149,28 +166,34 @@ class QEMUMachine(object):
>>>>>              try:
>>>>>                  self._qmp.cmd('quit')
>>>>>                  self._qmp.close()
>>>>> -            except:
>>>>> +            except:     # kill VM on any failure pylint: disable=3DW=
0702
>>>>
>>>> The bare except is almost certainly inappropriate.  Are you sure we
>>>> should silence pylint?
>>>>
>>>> Note that there's another bare except in launch(), visible in the
>>>> previous patch hunk.  I guess pylint is okay with that one because it
>>>> re-throws the exception.
>>>>
>>>> In case we should silence pylint: what's the scope of this magic pylint
>>>> comment?  Can we use the symbolic disable=3Dbare-except?
>>>>
>>>
>>> Yep, we can use symbolic name as well. Well more appropriate would be t=
o catch `SystemExit` and `KeyboardInterrupt`, treat them and raise them and=
 then ignore the rest of exceptions. I'll do that in the next version...
>>>
>>>>>                  self._popen.kill()
>>>>>=20=20
>>>>>              exitcode =3D self._popen.wait()
>>>>>              if exitcode < 0:
>>>>> -                sys.stderr.write('qemu received signal %i: %s\n' % (=
-exitcode, ' '.join(self._args)))
>>>>> +                sys.stderr.write('qemu received signal %i: %s\n'
>>>>> +                                 % (-exitcode, ' '.join(self._args)))
>>>>>              self._load_io_log()
>>>>>              self._post_shutdown()
>>>>>=20=20
>>>>>      underscore_to_dash =3D string.maketrans('_', '-')
>>>>> +
>>>>>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>>>>>          '''Invoke a QMP command and return the result dict'''
>>>>
>>>> Make that "and return the response", because that's how
>>>> docs/interop/qmp-spec.txt calls the thing.
>>>>
>>>
>>> Sure, no problem. I wanted to stress-out it's a dict and not encoded st=
ring, but it's probably given by the context.
>>=20
>> "return the response dict" would be fine with me.
>>=20
>
> Yes, I like that.
>
>>>>>          qmp_args =3D dict()
>>>>> -        for k in args.keys():
>>>>> +        for key in args.keys():
>>>>>              if conv_keys:
>>>>> -                qmp_args[k.translate(self.underscore_to_dash)] =3D a=
rgs[k]
>>>>> +                qmp_args[key.translate(self.underscore_to_dash)] =3D=
 args[key]
>>>>>              else:
>>>>> -                qmp_args[k] =3D args[k]
>>>>> +                qmp_args[key] =3D args[key]
>>>>>=20=20
>>>>>          return self._qmp.cmd(cmd, args=3Dqmp_args)
>>>>>=20=20
>>>>>      def command(self, cmd, conv_keys=3DTrue, **args):
>>>>> +        '''
>>>>> +        Invoke a QMP command and on success return result dict or on=
 failure
>>>>> +        raise exception with details.
>>>>> +        '''
>>>>
>>>> I'm afraid "result dict" is wrong: it need not be a dict.  "on failure
>>>> raise exception" adds precious little information, and "with details"
>>>> adds none.
>>>>
>>>> Perhaps:
>>>>
>>>>            Invoke a QMP command.
>>>>            On success return the return value.
>>>>            On failure raise an exception.
>>>>
>>>
>>> That is quite more verbose than I'd like and result in the same (for no=
n-native speaker), but I have no strong opinion here so changing it to your=
 version in v2.
>>>
>>>> The last sentence is too vague, but it's hard to do better because...
>>>>
>>>>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>>>>          if reply is None:
>>>>>              raise Exception("Monitor is closed")
>>>>
>>>> ... we raise Exception!  This code is a *turd* (pardon my french), and
>>>> PEP8 / pylint violations are the least of its problems.
>>>>
>>>
>>> Yep, adding rework-exceptions to my TODO list (for a future patchset)
>>>
>>>>> @@ -193,15 +216,18 @@ class QEMUMachine(object):
>>>>>          return events
>>>>>=20=20
>>>>>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
>>>>> -        # Test if 'match' is a recursive subset of 'event'
>>>>> -        def event_match(event, match=3DNone):
>>>>> +        '''Wait for event in QMP, optionally filter results by match=
.'''
>>>>
>>>> What is match?
>>>>
>>>> name and timeout not worth mentioning?
>>>>
>>>
>>> IMO this does not require full-blown documentation, it's not really a u=
ser-facing API and sometimes shorter is better. Anyway if you insist I can =
add full documentation of each parameter. I can even add `:type:` and `:ret=
urns:` and perhaps some `:warns:` and `:notes:` and I should descend and no=
te all the possible `:raises:`.
>>>
>>> ... the point I'm trying to make is I don't think it's necessary to go =
that much into details. Anyway if you think the params are necessary to lis=
t, then I can do that.
>>=20
>> Use your judgement.  The more detailed comments you add, the more
>> questions you'll get ;)
>>=20
>
> Sure, I'll try to improve (but not too much) that in the v6.
>
>>>>> +        # Test if 'match' is a recursive subset of 'event'; skips br=
anch
>>>>> +        # processing on match's value `None`
>>>>
>>>> What's a "recursive subset"?  What's "branch processing"?
>>>>
>>>> There's an unusual set of quotes around `None`.
>>>>
>>>
>>> Basically I was surprised why this function exists as one can directly =
compare dicts. It's because it works as the stock dict compare only on valu=
e "None" it breaks and assumes that "branch" matches. That's why I listed t=
he example as I'm unsure how to explain it in a human language.
>>>
>>> As for the `None`, in sphinx/doxygen it becomes "block" so I'm used to =
these, anyway people use `'`s and `"`s here so I'll change it in next versi=
on to be consistent.
>>=20
>> According to git-grep, we're using neither sphinx nor doxygen right now.
>>=20
>
> yep, as I said I'll change it for `"`.

I'd prefer plain None over "None", because the former is clearly the
built-in constant None, while the latter looks like a string.

>>>>> +        #    {"foo": {"bar": 1} matches {"foo": None}
>>>>
>>>> Aha: None servers as wildcard.
>>>
>>> Exactly.
>>>
>>>>
>>>>> +        def _event_match(event, match=3DNone):
>>>>
>>>> Any particular reason for renaming this function?
>>>>
>>>
>>> To emphasize it's internal, not a strong opinion but IMO looks better t=
his way.
>>=20
>> It's a nested function, how could it *not* be internal?
>>=20
>
> It is always internal for the computer, but humans sometimes need more po=
inters. I can drop this part if you really dislike that change but I'm used=
 to this notation.

PEP8:

    Method Names and Instance Variables

    Use the function naming rules: lowercase with words separated by
    underscores as necessary to improve readability.

    Use one leading underscore only for non-public methods and instance
    variables.

A nested function is not a method or instance variable.

>>>>>              if match is None:
>>>>>                  return True
>>>>>=20=20
>>>>>              for key in match:
>>>>>                  if key in event:
>>>>>                      if isinstance(event[key], dict):
>>>>> -                        if not event_match(event[key], match[key]):
>>>>> +                        if not _event_match(event[key], match[key]):
>>>>>                              return False
>>>>>                      elif event[key] !=3D match[key]:
>>>>>                          return False
>>>>> @@ -212,18 +238,22 @@ class QEMUMachine(object):
>>>>>=20=20
>>>>>          # Search cached events
>>>>>          for event in self._events:
>>>>> -            if (event['event'] =3D=3D name) and event_match(event, m=
atch):
>>>>> +            if (event['event'] =3D=3D name) and _event_match(event, =
match):
>>>>>                  self._events.remove(event)
>>>>>                  return event
>>>>>=20=20
>>>>>          # Poll for new events
>>>>>          while True:
>>>>>              event =3D self._qmp.pull_event(wait=3Dtimeout)
>>>>> -            if (event['event'] =3D=3D name) and event_match(event, m=
atch):
>>>>> +            if (event['event'] =3D=3D name) and _event_match(event, =
match):
>>>>>                  return event
>>>>>              self._events.append(event)
>>>>>=20=20
>>>>>          return None
>>>>>=20=20
>>>>>      def get_log(self):
>>>>> +        '''
>>>>> +        After self.shutdown or failed qemu execution this returns th=
e output
>>>>
>>>> Comma after execution, please.
>>>>
>>>
>>> OK
>>>
>>>>> +        of the qemu process.
>>>>> +        '''
>>>>>          return self._iolog
>>>>
>>>> I understand this code was factored out of qemu-iotests for use by
>>>> qtest.py.  That's okay, but I'd rather not serve as its maintainer.
>>>> -E2MUCH...
>>>>
>>>
>>> Yep, anyway it contains several useful methods/helpers and fixing basic=
 issues is the simplest way to get to know the code (and the submitting pro=
cess). Thank you for your time.
>>=20
>> You're welcome!
>>=20
>
> Thanks again,
> Luk=C3=A1=C5=A1
